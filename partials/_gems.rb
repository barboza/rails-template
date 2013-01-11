puts "Copying the Gemfile... ".magenta

copy_static_file 'Gemfile'
git :add => 'Gemfile'
git :commit => "-qm 'Adds Gemfile'"

puts "\n"
