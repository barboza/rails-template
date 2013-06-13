puts "Adding devise and omniauth".magenta

# -- Gems --
gsub_file 'Gemfile', /#gem 'devise/, "gem \'devise"
gsub_file 'Gemfile', /#gem 'omniauth/, "gem \'omniauth"
gsub_file 'Gemfile', /#gem 'omniauth-facebook/, "gem \'omniauth-facebook"
gsub_file 'Gemfile', /#gem 'omniauth-twitter/, "gem \'omniauth-twitter"
gsub_file 'Gemfile', /#gem 'devise-i18n/, "gem \'devise-i18n"

after_bundler do
  generate 'devise:install'

  # -- Configs --
  configs = <<CONFIGS

config.omniauth :facebook, 'APP_ID', 'APP_SECRET', scope: 'email', image_size: 'normal'
config.omniauth :twitter, 'APP_ID', 'APP_SECRET'
CONFIGS

  in_root do
    inject_into_file 'config/initializers/devise.rb', configs, {before: "\nend", verbose: false}
  end
  git :add => '.'
  git :commit => "-aqm 'Configure Devise and Omniauth'"

  # -- Models --
  copy_static_file 'app/models/user.rb'
  copy_static_file 'app/models/authorization.rb'

  # -- Migrations --
  copy_static_file 'db/migrate/devise_create_users.rb', "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_devise_create_users.rb"
  copy_static_file 'db/migrate/create_authorizations.rb', "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_i+1}_create_authorizations.rb"

  # -- Model specs --
  copy_static_file 'spec/models/user_spec.rb'
  copy_static_file 'spec/models/authorization_spec.rb'
  copy_static_file 'spec/support/blueprints.rb'

  git :add => '.'
  git :commit => "-aqm 'Create User and Authorization models'"

  # -- Controllers --
  copy_static_file 'app/controllers/users/omniauth_callbacks_controller.rb'
  copy_static_file 'app/controllers/authorizations_controller.rb'

  # -- Controller specs --
  copy_static_file 'spec/controllers/users/omniauth_callbacks_controller_spec.rb'
  copy_static_file 'spec/controllers/authorizations_controller_spec.rb'

  # -- Routes --
  route "devise_for :users, :controllers => { :omniauth_callbacks => \"users/omniauth_callbacks\" }"
  route "resources :authorizations, only: [:destroy]"

  git :add => '.'
  git :commit => "-aqm 'Create Users::OmniauthCallbacks and Authorizations controller'"

  # -- Views --
  run "mkdir app/views/devise/"
  run "cp -rf #{@static_files}/app/views/devise/ app/views/devise/"
  copy_static_file 'config/locales/devise.en.yml'
  git :add => '.'
  git :commit => "-aqm 'Create Devise views'"

  in_root do
    run "rake db:migrate"
  end
end
