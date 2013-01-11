#-- Backbone.js --
if ['backbone', 'backbone_underscore'].include? prefs[:javascript]
  puts "Adding the Backbone.js".magenta

  run "curl http://backbonejs.org/backbone.js > app/assets/javascripts/lib/backbone.js"
  gsub_file 'app/assets/javascripts/application.js', "//= require_tree ./lib", "//= require ./lib/backbone.js
//= require_tree ./lib"

  git :add => '.'
  git :commit => "-qm 'Adds Backbone.js'"
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
  git :commit => "-qm 'Adds Underscore.js'"
end
