gsub_file 'Gemfile', /#gem 'simple_form/, "gem 'simple_form"

after_bundler do
  if prefer :wrappers_simple_form, 'bootstrap'
    generate 'simple_form:install --bootstrap'
  elsif prefer :wrappers_simple_form, 'foundation'
    generate 'simple_form:install --foundation'
  else
    generate 'simple_form:install'
  end
  git :add => '.'
  git :commit => "-aqm 'Configures simple_form.'"
end
