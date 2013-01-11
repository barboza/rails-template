#-- Backbone.js --
if prefer :javascript, 'backbone' or prefer :javascript, 'backbone_underscore'
  puts "Adding the Backbone.js".magenta

  run "curl http://backbonejs.org/backbone.js > app/assets/javascripts/lib/backbone.js"
  gsub_file 'app/assets/javascripts/application.js', "//= require_tree ./lib", "//= require ./lib/backbone.js
//= require_tree ./lib"

  git :add => '.'
  git :commit => "-qm 'Adds Backbone.js'"
end

#-- Underscore.js --
if prefer :javascript, 'underscore' or prefer :javascript, 'backbone_underscore'
  puts "Adding the Underscore.js".magenta

  run "curl http://documentcloud.github.com/underscore/underscore.js > app/assets/javascripts/lib/underscore.js"

  if prefer :javascript, 'backbone' or prefer :javascript, 'backbone_underscore'
    gsub_file 'app/assets/javascripts/application.js', "//= require ./lib/backbone.js", "//= require ./lib/underscore.js
//= require ./lib/backbone.js"
  else
    gsub_file 'app/assets/javascripts/application.js', "//= require_tree ./lib", "//= require ./lib/underscore.js
//= require_tree ./lib"
  end

  git :add => '.'
  git :commit => "-qm 'Adds Underscore.js'"
end
