# Rails Template

A Rails Template that creates a great Rails starter app.

## Your Options

The Rails Template will ask to you for various preferences, some of which will depend on previous choices.

Here’s an example:

```
question  What front-end framework do you want to use?
      1)  None
      2)  Twitter Bootstrap
      3)  Zurb Foundation

question  What Javascript framework do you want to use?
      1)  None
      2)  AngularJS
      3)  Backbone.js
      4)  Underscore.js
      5)  Backbone.js, Underscore.js

question  Do you want use CoffeeScript? [y/n]

question  Pre configure the Google Analytics? [y/n]

question  Install a starter app?
      1)  None
      2)  Home Page
      3)  Home Page, User Authentication (Devise and Omniauth)
      4)  User Authentication (Devise and Omniauth)


question  Use a form builder gem?
      1)  None
      2)  SimpleForm

question  What name should the custom gemset have? [app_name]
question  Configure/Create Heroku app? [y/n]
```

## Hidden Features

- Cleanup your app - Remove unused files
- Database configurations - database.sample.yml
- Flash messages partial
- Header and Footer partial for layout
- Great .gitignore
- Great and useful gems (Check the Gemfile :D)
- Config the rails generators
- Devise views in slim and I18n

## Some Preferences

- PostgreSQL
- Slim
- Sass
- Init.js
- Shoulda
- Machinist

## Usage

1. Clone rails-template to your home directory.
```
git clone git://github.com/josemarluedke/rails-template.git
```

2. Run rails new app command using this template.
```
rails new app_name -m ~/rails-template/template.rb
```

4. That's it! Everything should be in place.

## Rails versions

### Rails 4

The current master branch is for Rails 4 support.

### Rails 3.2

For generate a rails 3.2 application using this template, please use the `rails3.2-stable` branch.

## Maintainer

- Josemar Davi Luedke - [josemarluedke.com](http://josemarluedke.com)

## Contributors

- Pedro Nascimento - [@lunks](https://github.com/lunks)
- Rodrigo Pinto - [@rodrigopinto](https://github.com/rodrigopinto)
- Sylvestre Mergulhao [@mergulhao](https://github.com/mergulhao)
- Ramon Bispo - [@RamonPage](https://github.com/RamonPage)
- Rafael Lima - [@rafaelp](https://github.com/rafaelp)
- Irio Irineu Musskopf - [@irio](https://github.com/irio)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
