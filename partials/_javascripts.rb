puts "Adding the defaults javascripts... ".magenta

# Default folders
run "mkdir app/assets/javascripts/lib"
run "echo '' > app/assets/javascripts/lib/.gitkeep"

gsub_file 'app/assets/javascripts/application.js', "//= require_tree .", "
//= require_tree ./lib
"

git :add => '.'
git :commit => "-aqm 'Adds default javascript things'"

after_bundler do
	generate 'initjs:install'

	git :add => '.'
	git :commit => "-aqm 'Installs initjs'"
end
