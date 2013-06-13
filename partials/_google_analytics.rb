puts "Configuring the Google Analytics...".magenta

gsub_file 'Gemfile', /#gem 'rack-google-analytics/, "gem 'rack-google-analytics"
gsub_file 'config/environments/production.rb', "::Application.configure do", "::Application.configure do
  # Google Analytics
  config.middleware.use Rack::GoogleAnalytics, :tracker => 'YOUR-ANALYTICS-CODE'
"
git :add => '.'
git :commit => "-aqm 'Add config for google analytics into production config file'"
puts "\n"
