puts "Locales ...".magenta

copy_static_file 'config/locales/devise.views.en.yml'
copy_static_file 'config/locales/devise.simple_form.en.yml'
git :add => '.'
git :commit => "-aqm 'Adds default devise locales for EN'"

