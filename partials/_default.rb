puts "Adding default stuff ...".magenta

copy_static_file 'app/views/layouts/_flash.html.slim'
git :add => '.'
git :commit => "-aqm 'Add partial for flash messages'"


copy_static_file 'app/views/layouts/_header.html.slim'
copy_static_file 'app/views/layouts/_footer.html.slim'
git :add => '.'
git :commit => "-aqm 'Add header and footer partial for layout'"



copy_static_file 'app/views/layouts/application.html.slim'
gsub_file 'app/views/layouts/application.html.slim', /INITJS_PROJECT/, @app_name.camelize
gsub_file 'app/views/layouts/application.html.slim', /PROJECT/, @app_name
git :add => '.'
git :commit => "-aqm 'Add application layout in slim'"



copy_static_file '.gitignore'
git :add => '.'
git :commit => "-aqm 'Add .gitignore'"



gsub_file 'config/environments/development.rb', "::Application.configure do", "::Application.configure do
  Slim::Engine.set_default_options :pretty => true"
git :add => '.'
git :commit => "-aqm 'Add Slim pretty option'"



gsub_file 'app/controllers/application_controller.rb', "end", "
  protected
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,
                                                            :email,
                                                            :password,
                                                            :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email,
                                                            :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name,
                                                                   :email,
                                                                   :password,
                                                                   :password_confirmation,
                                                                   :current_password) }
  end
end
"
git :add => '.'
git :commit => "-aqm 'Add render_404 to application controller'"
puts "\n"
