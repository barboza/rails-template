puts "Adding default stuff ...".magenta

copy_static_file 'app/views/layouts/_flash.html.slim'
git :add => '.'
git :commit => "-aqm 'Added partial for flash messages'"



copy_static_file 'app/views/layouts/application.html.slim'
gsub_file 'app/views/layouts/application.html.slim', /PROJECT/, @app_name
git :add => '.'
git :commit => "-aqm 'Added application layout in slim'"



copy_static_file 'config/locales/rails.pt-BR.yml'
git :add => '.'
git :commit => "-aqm 'Added rails locale for pt-BR'"



copy_static_file '.gitignore'
git :add => '.'
git :commit => "-aqm 'Added .gitignore'"



gsub_file 'app/controllers/application_controller.rb', "end", "
  protected
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
end
"
git :add => '.'
git :commit => "-aqm 'Added render_404 to application controller'"
puts "\n"
