puts "Setting up RSpec ... ".magenta

remove_dir 'test'

copy_static_file 'spec/support/capybara.rb'

git :add => '.'
git :commit => "-aqm 'Add RSpec support files'"

after_bundler do
  generate 'rspec:install'
  copy_static_file '.rspec'
  generate 'machinist:install'
  git :add => '.'
  git :commit => "-aqm 'Configure RSpec'"

  if prefs[:devise]
     configs = <<CONFIGS

  config.include Devise::TestHelpers, type: :controller
CONFIGS

    in_root do
      inject_into_file 'spec/rails_helper.rb', configs, {after: "do |config|", verbose: false}
    end

    git :add => '.'
    git :commit => "-aqm 'Configure Devise helper for specs controllers'"
  end
end

puts "\n"

