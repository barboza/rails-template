puts "Setting up RSpec ... ".magenta

remove_dir 'test'

copy_static_file 'spec/support/capybara.rb'

git :add => '.'
git :commit => "-aqm 'Add RSpec support files.'"

after_bundler do
  generate 'rspec:install'
  copy_static_file '.rspec'
  generate 'machinist:install'
  git :add => '.'
  git :commit => "-aqm 'Configure RSpec.'"
end

puts "\n"

