after_bundler do
  #-- Angular.js --
  if ['angularjs'].include? prefs[:javascript]
    puts "Adding the AngularJS".magenta
    gsub_file 'Gemfile', /#gem 'angular-rails/, "gem 'angular-rails"

    # Default folders for angular
    run "mkdir app/assets/javascripts/app/controllers"
    run "mkdir app/assets/javascripts/app/controllers/.gitkeep"
    run "mkdir app/assets/javascripts/app/filters"
    run "mkdir app/assets/javascripts/app/filters/.gitkeep"
    run "mkdir app/assets/javascripts/app/services"
    run "mkdir app/assets/javascripts/app/services/.gitkeep"
    run "mkdir app/assets/javascripts/app/widgets"
    run "mkdir app/assets/javascripts/app/widgets/.gitkeep"
    run "mkdir app/assets/javascripts/app/templates"
    run "mkdir app/assets/javascripts/app/templates/.gitkeep"

    gsub_file 'app/assets/javascripts/application.js', "//= require_tree ./lib", "//= require angular
//= require_tree ./lib"

    git :add => '.'
    git :commit => "-aqm 'Add AngularJS'"
  end

  unless ['angularjs'].include? prefs[:javascript]
    gsub_file 'Gemfile', /\n  #gem 'angular-rails'/, ""
    git :add => '.'
    git :commit => "-aqm 'Remove angular-rails from Gemfile'"
  end
end
