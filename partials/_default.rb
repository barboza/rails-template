puts "Adding default stuff ...".magenta

copy_static_file 'app/views/layouts/_flash.html.slim'
git :add => '.'
git :commit => "-aqm 'Added partial for flash messages'"


copy_static_file 'app/views/layouts/_header.html.slim'
copy_static_file 'app/views/layouts/_footer.html.slim'
git :add => '.'
git :commit => "-aqm 'Adds header and footer partial for layout'"



copy_static_file 'app/views/layouts/application.html.slim'
gsub_file 'app/views/layouts/application.html.slim', /INITJS_PROJECT/, @app_name.camelize
gsub_file 'app/views/layouts/application.html.slim', /PROJECT/, @app_name
git :add => '.'
git :commit => "-aqm 'Adds application layout in slim'"



copy_static_file '.gitignore'
git :add => '.'
git :commit => "-aqm 'Adds .gitignore'"



gsub_file 'config/environments/development.rb', "::Application.configure do", "::Application.configure do
  Slim::Engine.set_default_options :pretty => true"
git :add => '.'
git :commit => "-aqm 'Adds Slim pretty option'"



gsub_file 'app/controllers/application_controller.rb', "end", "
  protected
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
end
"
git :add => '.'
git :commit => "-aqm 'Adds render_404 to application controller'"
puts "\n"
