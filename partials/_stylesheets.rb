say "Configuring stylesheets...".magenta

run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.sass'

git :add => '.'
git :rm => 'app/assets/stylesheets/application.css'
git :commit => "-aqm 'Rename application.css to application.sass'"

if prefer :frontend, 'bootstrap'
  gsub_file 'Gemfile', /#gem 'bootstrap-sass/, "gem 'bootstrap-sass"
  gsub_file 'Gemfile', /\n  #gem 'foundation-rails'/, ""
  run "echo '\n@import bootstrap' >> app/assets/stylesheets/application.sass"
  git :add => '.'
  git :commit => "-aqm 'Add twitter bootstrap'"

elsif prefer :frontend, 'foundation'
  gsub_file 'Gemfile', /#gem 'foundation-rails/, "gem 'foundation-rails"
  gsub_file 'Gemfile', /\n  #gem 'bootstrap-sass'/, ""
  run "echo '\n@import foundation' >> app/assets/stylesheets/application.sass"
  git :add => '.'
  git :commit => "-aqm 'Add Zurb Foundation'"

else
  gsub_file 'Gemfile', /\n  #gem 'bootstrap-sass'/, ""
  gsub_file 'Gemfile', /\n  #gem 'foundation-rails'/, ""
  git :add => '.'
  git :commit => "-aqm 'Remove bootstrap-sass and zurb-foundation from Gemfile'"
end
