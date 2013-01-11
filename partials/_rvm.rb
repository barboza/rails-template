# Set up rvm private gemset
require 'rvm'
puts "Setting up RVM gemset and installing bundled gems (may take a while) ... ".magenta

# Need to strip colors in case rvm_pretty_print_flag is enabled in user's .rvmrc
rvm_list = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), '')

current_ruby = rvm_list.match(/=.? ([^ ]+)/)[1]
desired_ruby = prefs[:desired_ruby]
desired_ruby = current_ruby if desired_ruby.blank?

@env = RVM::Environment.new(desired_ruby)

gemset_name = prefs[:gemset_name]
gemset_name = @app_name if gemset_name.blank?

#This will work after my pull request gets accepted
#https://github.com/wayneeseguin/rvm-gem/pull/9
puts "Creating gemset #{@app_name} in #{desired_ruby}"
@env.gemset_create(app_name)
puts "Now using gemset #{@app_name}"
@env.gemset_use!(app_name)

# Since the gemset is likely empty, manually install bundler so it can install the rest
run "gem install bundler --no-ri --no-rdoc"

# Install all other gems needed from Gemfile
copy_static_file '.rvmrc'
gsub_file '.rvmrc', /PROJECT/, @app_name
gsub_file '.rvmrc', /RUBYVERSION/, desired_ruby

git :add => '.rvmrc'
git :commit => "-qm 'Adds .rvmrc'"
git :add => 'Gemfile.lock'
git :commit => "-qm 'Adds Gemfile.lock'"

puts "\n"
