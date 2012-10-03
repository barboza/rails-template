puts "Locales ...".magenta

@use_locale_pt = would_you_like? "Use pt-BR locales? [y,n]".red

if @use_locale_pt
  copy_static_file 'config/locales/rails.pt-BR.yml'
  git :add => '.'
  git :commit => "-aqm 'Added rails locale for pt-BR'"
end


copy_static_file 'config/locales/devise.views.en.yml'
copy_static_file 'config/locales/devise.simple_form.en.yml'
git :add => '.'
git :commit => "-aqm 'Added default locales for en'"

