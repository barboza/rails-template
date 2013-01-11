puts "Adding the defaults javascripts... ".magenta

if prefs[:coffee]
  copy_static_file 'app/assets/javascripts/app.js.coffee'
else
  copy_static_file 'app/assets/javascripts/app.js'
end

# Default folders
run "mkdir app/assets/javascripts/lib"
run "echo '' > app/assets/javascripts/lib/.gitkeep"
run "mkdir app/assets/javascripts/app"
run "echo '' > app/assets/javascripts/app/.gitkeep"

gsub_file 'app/assets/javascripts/application.js', "//= require_tree .", "
//= require_tree ./lib
//= require ./app.js
//= require_tree ./app
//= require init.js
"

git :add => '.'
git :commit => "-aqm 'Add defaults javascripts'"
