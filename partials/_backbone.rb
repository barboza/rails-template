if would_you_like? "Do you want use Backbone.js and Underscore.js [y,n]".red
  puts "Adding the Backbone.js and Underscore.js... ".magenta

  run "curl http://documentcloud.github.com/underscore/underscore.js > app/assets/javascripts/lib/underscore.js"
  run "curl http://backbonejs.org/backbone.js > app/assets/javascripts/lib/backbone.js"

  gsub_file 'app/assets/javascripts/application.js', "//= require_tree ./lib", "//= require ./lib/underscore.js
//= require ./lib/backbone.js
//= require_tree ./lib"

  git :add => '.'
  git :commit => "-qm 'Adds backbone.js and underscore.js'"
end
