say "Configuring stylesheets...".magenta

run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.sass'

git :add => '.'
git :rm => 'app/assets/stylesheets/application.css'
git :commit => "-aqm 'Rename application.css to application.sass'"

if prefer :frontend, 'bootstrap'
  gsub_file 'Gemfile', /#gem 'bootstrap-sass/, "gem 'bootstrap-sass"
  gsub_file 'Gemfile', /\n  #gem 'foundation-rails'/, ""
  gsub_file 'Gemfile', /#gem 'bourbon/, ""
  gsub_file 'Gemfile', /#gem 'neat/, ""
  gsub_file 'Gemfile', /#gem 'bitters/, ""
  gsub_file 'Gemfile', /#gem 'refills/, ""
  run "echo '\n@import bootstrap' >> app/assets/stylesheets/application.sass"
  git :add => '.'
  git :commit => "-aqm 'Add twitter bootstrap'"

elsif prefer :frontend, 'foundation'
  gsub_file 'Gemfile', /#gem 'foundation-rails/, "gem 'foundation-rails"
  gsub_file 'Gemfile', /\n  #gem 'bootstrap-sass'/, ""
  gsub_file 'Gemfile', /#gem 'bourbon/, ""
  gsub_file 'Gemfile', /#gem 'neat/, ""
  gsub_file 'Gemfile', /#gem 'bitters/, ""
  gsub_file 'Gemfile', /#gem 'refills/, ""
  run "echo '\n@import foundation' >> app/assets/stylesheets/application.sass"
  git :add => '.'
  git :commit => "-aqm 'Add Zurb Foundation'"

elsif prefer :frontend, 'bourbon'
  run 'rm app/assets/stylesheets/application.sass'
  copy_static_file 'app/assets/stylesheets/application.css.scss'
  gsub_file 'Gemfile', /\n  #gem 'bootstrap-sass'/, ""
  gsub_file 'Gemfile', /\n  #gem 'foundation-rails'/, ""
  gsub_file 'Gemfile', /#gem 'bourbon/, "gem 'bourbon"
  gsub_file 'Gemfile', /#gem 'neat/, "gem 'neat"
  gsub_file 'Gemfile', /#gem 'bitters/, "gem 'bitters"
  gsub_file 'Gemfile', /#gem 'refills/, "gem 'refills"

  after_bundler do
    inside('app/assets/stylesheets') do
      run "bitters install"
    end
  end

else
  gsub_file 'Gemfile', /\n  #gem 'bootstrap-sass'/, ""
  gsub_file 'Gemfile', /\n  #gem 'foundation-rails'/, ""
  gsub_file 'Gemfile', /#gem 'bourbon/, ""
  gsub_file 'Gemfile', /#gem 'neat/, ""
  gsub_file 'Gemfile', /#gem 'bitters/, ""
  gsub_file 'Gemfile', /#gem 'refills/, ""
  git :add => '.'
  git :commit => "-aqm 'Remove bootstrap-sass and zurb-foundation from Gemfile'"
end
