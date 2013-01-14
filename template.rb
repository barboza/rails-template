%w{colored}.each do |component|
  if Gem::Specification.find_all_by_name(component).empty?
    run "gem install #{component}"
    Gem.refresh
    Gem::Specification.find_by_name(component).activate
  end
end

require "rails"
require "colored"
require "bundler"

@current_ruby = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), '').match(/=.? ([^ ]+)/)[1]
@template_root = File.expand_path(File.join(File.dirname(__FILE__)))
@partials     = File.join(@template_root, 'partials')
@static_files = File.join(@template_root, 'files')
@current_recipe = nil
@configs = {}
@prefs = {}
@after_blocks = []
@after_everything_blocks = []
@before_configs = {}

def after_bundler(&block); @after_blocks << [@current_recipe, block]; end
def after_everything(&block); @after_everything_blocks << [@current_recipe, block]; end
def before_config(&block); @before_configs[@current_recipe] = block; end
def prefs; @prefs end
def prefer(key, value); @prefs[key].eql? value end
def apply_n(partial); apply "#{@partials}/_#{partial}.rb"; end
def say_custom(tag, text); say "\033[1m\033[36m" + tag.to_s.rjust(10) + "\033[0m" + "  #{text}" end

def ask_wizard(question, tag = "prompt")
  ask "\033[1m\033[30m\033[46m" + (@current_recipe || tag).rjust(10) + "\033[1m\033[36m" + "  #{question}\033[0m"
end

# Copy a static file from the template into the new application
def copy_static_file(path, new_path = false)
  new_path = path unless new_path
  remove_file new_path
  file new_path, File.read(File.join(@static_files, path))
end

def yes_wizard?(question)
  answer = ask_wizard(question + " \033[33m[y/n]\033[0m", "question")
  case answer.downcase
    when "yes", "y"
      true
    when "no", "n"
      false
    else
      yes_wizard?(question)
  end
end

def multiple_choice(question, choices)
  say_custom('question', question)
  values = {}
  choices.each_with_index do |choice,i|
    values[(i + 1).to_s] = choice[1]
    say_custom( (i + 1).to_s + ')', choice[0] )
  end
  answer = ask_wizard("Enter your selection:") while !values.keys.include?(answer)
  values[answer]
end

puts "\n========================================================="
puts " RAILS TEMPLATE".yellow.bold
puts "=========================================================\n"

# -- Front-end frameworks --
prefs[:frontend] = multiple_choice "What front-end framework do you want to use?",
  [["None", "none"],
   ["Twitter Bootstrap", "bootstrap"],
   ["Zurb Foundation", "foundation"]]

# -- Javascript frameworks --
prefs[:javascript] = multiple_choice "What Javascript framework do you want to use?",
  [["None", "none"],
   ["AngularJS", "angularjs"],
   ["Backbone.js", "backbone"],
   ["Underscore.js", "underscore"],
   ["Backbone.js, Underscore.js", "backbone_underscore"]]

# -- CoffeeScript --
prefs[:coffee] = yes_wizard? "Do you want use CoffeeScript?"

# -- Google Analytics --
prefs[:analytics] = yes_wizard? "Pre configure the Google Analytics?"

# -- Starter app --
prefs[:starter_app] =  multiple_choice "Install a starter app?",
  [["None", "none"],
   ["Home Page", "home"],
   ["Home Page, User Authentication (Devise and Omniauth)", "home_devise"],
   ["User Authentication (Devise and Omniauth)", "devise"]]

prefs[:devise] = true if ['devise', 'home_devise'].include? prefs[:starter_app]
prefs[:home_page] = true if ['home', 'home_devise'].include? prefs[:starter_app]

# -- SimpleFrom
prefs[:form_builder] = 'simple_form' if prefs[:devise]
prefs[:form_builder] = multiple_choice "Use a form builder gem?",
  [["None", "none"], ["SimpleForm", "simple_form"]] unless prefs[:devise]
if prefer :form_builder, 'simple_form'
  prefs[:wrappers_simple_form] = multiple_choice "Generate wrappers for simple_form?",
    [["None", "none"],
     ["Twitter Bootstrap", "bootstrap"],
     ["Zurb Foundation", "foundation"]]
end

# -- RVM ---
prefs[:rvm] = yes_wizard? "Create a project-specific RVM gemset and .rvmrc?"
if prefs[:rvm]
  prefs[:desired_ruby] = ask_wizard("Which RVM Ruby would you like to use? [#{@current_ruby}]")
  prefs[:gemset_name] = ask_wizard("What name should the custom gemset have? [#{@app_name}]")
end

# -- Heroku --
prefs[:heroku] = yes_wizard? "Configure/Create Heroku app?"
if prefs[:heroku]
  prefs[:heroku_staging] = yes_wizard? "Create staging app? (#{@app_name.gsub('_','')}-staging.herokuapp.com)"
  prefs[:heroku_deploy] = yes_wizard? "Deploy immediately?"
  prefs[:heroku_domain] = ask_wizard "Add custom domain(customdomain.com) or leave blank"
end

# -- Applys --
apply_n :git
apply_n :cleanup
apply_n :gems
apply_n :default
apply_n :google_analytics if prefs[:analytics]
apply_n :database
apply_n :rspec
apply_n :javascripts
apply_n :backbone_underscore
apply_n :angularjs
apply_n :stylesheets
apply_n :generators
apply_n :home_page if prefs[:home_page]
apply_n :rvm if prefs[:rvm]
apply_n :devise_omniauth if prefs[:devise]
apply_n :simple_form if prefer :form_builder, 'simple_form'
after_bundler do
  apply_n :heroku if prefs[:heroku]
end

run 'bundle install'
git :add => 'Gemfile.lock'
git :commit => "-qm 'Adds Gemfile.lock'"

puts "\nRunning after Bundler callbacks."
@after_blocks.each{|b| config = @configs[b[0]] || {}; @current_recipe = b[0]; b[1].call}

@current_recipe = nil
puts "\nRunning after everything callbacks."
@after_everything_blocks.each{|b| config = @configs[b[0]] || {}; @current_recipe = b[0]; b[1].call}

puts "\n========================================================="
puts " INSTALLATION COMPLETE!".yellow.bold
puts "=========================================================\n\n\n"
