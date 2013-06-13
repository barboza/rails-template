#-- Backbone.js --
if ['backbone', 'backbone_underscore'].include? prefs[:javascript]
  puts "Adding the Backbone.js".magenta

  # Default folders for backbone
  run "mkdir app/assets/javascripts/app/routers"
  run "mkdir app/assets/javascripts/app/routers/.gitkeep"
  run "mkdir app/assets/javascripts/app/collections"
  run "mkdir app/assets/javascripts/app/collections/.gitkeep"
  run "mkdir app/assets/javascripts/app/models"
  run "mkdir app/assets/javascripts/app/models/.gitkeep"
  run "mkdir app/assets/javascripts/app/templates"
  run "mkdir app/assets/javascripts/app/templates/.gitkeep"
  run "mkdir app/assets/javascripts/app/views"
  run "mkdir app/assets/javascripts/app/views/.gitkeep"

  run "curl http://backbonejs.org/backbone.js > app/assets/javascripts/lib/backbone.js"
  gsub_file 'app/assets/javascripts/application.js', "//= require_tree ./lib", "//= require ./lib/backbone.js
//= require_tree ./lib"

  git :add => '.'
  git :commit => "-qm 'Add Backbone.js'"
end

#-- Underscore.js --
if ['underscore', 'backbone_underscore'].include? prefs[:javascript]
  puts "Adding the Underscore.js".magenta

  run "curl http://documentcloud.github.com/underscore/underscore.js > app/assets/javascripts/lib/underscore.js"

  if ['backbone', 'backbone_underscore'].include? prefs[:javascript]
    gsub_file 'app/assets/javascripts/application.js', "//= require ./lib/backbone.js", "//= require ./lib/underscore.js
//= require ./lib/backbone.js"
  else
    gsub_file 'app/assets/javascripts/application.js', "//= require_tree ./lib", "//= require ./lib/underscore.js
//= require_tree ./lib"
  end

  git :add => '.'
  git :commit => "-qm 'Add Underscore.js'"
end
