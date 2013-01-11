say "Configuring stylesheets...".magenta

run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.sass'

git :add => '.'
git :rm => 'app/assets/stylesheets/application.css'
git :commit => "-aqm 'Renames application.css to application.sass'"

if prefer :frontend, 'bootstrap'
  gsub_file 'Gemfile', /#gem 'bootstrap-sass/, "gem 'bootstrap-sass"
  gsub_file 'Gemfile', /\n  #gem 'zurb-foundation'/, ""
  run "echo '\n@import bootstrap' >> app/assets/stylesheets/application.sass"
  git :add => '.'
  git :commit => "-aqm 'Adds twitter bootstrap'"

elsif prefer :frontend, 'foundation'
  gsub_file 'Gemfile', /#gem 'zurb-foundation/, "gem 'zurb-foundation"
  gsub_file 'Gemfile', /\n  #gem 'bootstrap-sass'/, ""
  run "echo '\n@import foundation' >> app/assets/stylesheets/application.sass"
  git :add => '.'
  git :commit => "-aqm 'Adds Zurb Foundation'"

else
  gsub_file 'Gemfile', /\n  #gem 'bootstrap-sass'/, ""
  gsub_file 'Gemfile', /\n  #gem 'zurb-foundation'/, ""
  git :add => '.'
  git :commit => "-aqm 'Removes bootstrap-sass and zurb-foundation from Gemfile'"
end


