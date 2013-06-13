puts "Adding the Home Page... ".magenta

after_bundler do
  generate :controller, "Home index"
  gsub_file 'config/routes.rb', /get \"home\/index\"/, 'root :to => "home#index"'
  git :add => '.'
  git :commit => "-aqm 'Add Home Page'"
end
