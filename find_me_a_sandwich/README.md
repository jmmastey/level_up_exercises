# Find Me A Sandwich

I'm hungry and could use a sandwich.  However, I have no idea what type of sandwich I want, or from where.

<a href="http://xkcd.com/149/" target="xkcd"><img src="http://imgs.xkcd.com/comics/sandwich.png" alt="xkcd - Make me a sandwich" /></a>

We have a pretty basic app called "Find Me A Sandwich" which can lookup menus from different restaurants.  However, it doesn't let me save my favorite sandwiches for later, or let me look up others' favorites.

Your job is to allow me to favorite my sandwiches, and look up the favorites of others.

## Table of Contents
* [Overview](#overview)
* [The Exercise](#the-exercise)
  - [Part 0 - Getting Started](#part-0---getting-started)
  - [Part 1 - Behavioral Tests](#part-1---behavioral-tests)
  - [Part 2 - Views](#part-2---views)
  - [Part 3 - Controller](#part-3---controller)
  - [Part 4 - Model](#part-4---model)
  - [Part 5 - API](#part-5---api)
* [Resources](#resources)
* [Enabling PostgreSQL Support](#enabling-postgresql-support)

## Overview

Find Me A Sandwich is written in Rails, a Ruby-based MVC framework.  The MVC architectural pattern separates applications into three interconnected parts: the **m**odel, **v**iew and **c**ontroller.  The **model** component is responsible for storing data and containing the business logic of the application.  The **view** generates output to the user.  In Rails, this output usually takes the form of HTML (for browsers) or JSON (for API consumers).  Finally, the **controller** links the two, accepting web requests from the client, sending messages to the model, and rendering the views based on the state of the model.  Take a look at the [resources](#resources) below for more information on MVC and Rails.

## The Exercise

### Part 0 - Getting Started
First, you'll need to get everything set up. Use RSpec to execute the existing unit tests using the command `bundle exec rspec`. You should make sure everything passes, and then stand the app up and make sure you can navigate to it in your browser.

### Part 1 - Behavioral Tests
As with any behavior-driven developed program, you'll be starting with the tests.  Add a series of [Cucumber](https://cucumber.io) features for favoriting/unfavoriting meals, and looking up others' favorites.

```
As a user
I want to see what meals I have favorited
In order to decide what to eat
```

```
As a user
I want to favorite my meals
In order to find them later
```

```
As a user
I want to unfavorite my meals
In order to track only the meals I want
```

```
As a user
I want to find the favorite meals of my friends
In order to decide what to eat
```

Keep in mind that this outside-in approach will require you to mock some objects (especially models).  Take a look at [RSpec mocks](https://www.relishapp.com/rspec/rspec-mocks/docs) for reference.

### Part 2 - Views
Now that we have some behavioral tests up, let's add some views.  Use [Haml](http://haml.info) to modify the existing menu and add a "Favorite" option to each menu item. Also add views to:
* View and manage your favorites
* Browse others' favorites

### Part 3 - Controller
Now let's add a controller to receive requests related to our favorites and respond with the appropriate rendered view.  Start with some [specs](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs). Then add the [controller](http://edgeguides.rubyonrails.org/action_controller_overview.html) itself.

### Part 4 - Model
Finally, we need to create the Favorite [model](http://edgeguides.rubyonrails.org/active_record_basics.html) and appropriate [database migration](http://edgeguides.rubyonrails.org/active_record_migrations.html).  The model should [reference](http://edgeguides.rubyonrails.org/association_basics.html) a `User` and a `MenuItem`.

**Bonus points:** Use PostgreSQL for the database instead of SQLite. See section below on [*Enabling PostgreSQL Support*](#enabling-postgresql-support).

### Part 5 - API
This site's search capabilities aren't very useful.  I want to be able to search restaurants by menu item.  We've got developers working on the interface, but we need someone to update the Locu API client library.  Take a look at the [Locu docs](https://dev.locu.com/documentation/#venue-search-api) and update `Locu::Client#search_venues` to support searching by menu items.

## Resources
* Capybara
  - [Capybara Github](https://github.com/jnicklas/capybara)
  - [Capybara Cheat Sheet](https://gist.github.com/zhengjia/428105)
* Cucumber
  - [Cucumber.io](https://cucumber.io/)
  - [The training wheels came off](http://aslakhellesoy.com/post/11055981222/the-training-wheels-came-off) - Article on why not to use `web_steps.rb` and how to follow best BDD practices
* Haml
  - [Haml Reference](http://haml.info/docs/yardoc/file.REFERENCE.html)
  - [Haml Tutorial](http://haml.info/tutorial.html)
* [Locu Venue Search API](https://dev.locu.com/documentation/#venue-search-api)
* MVC
  - [Wikipedia](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
* Rails
  - [Ruby on Rails - Framework](http://www.tutorialspoint.com/ruby-on-rails/rails-framework.htm) - Brief intro to MVC and Rails
  - [Ruby on Rails Guides](http://guides.rubyonrails.org/index.html)
    * [Active Support Core Extensions](http://edgeguides.rubyonrails.org/active_support_core_extensions.html) - Learning these extensions will save you a lot of time
* RSpec
  - [Better Specs](http://betterspecs.org/) - RSpec best practices
  - [Controller Specs Reference](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs)
  - [RSpec Mocks](https://www.relishapp.com/rspec/rspec-mocks/docs) - A guide on mocking objects in RSpec (very useful when testing views & controllers)
* Other resources
  - [Factory Girl](https://github.com/thoughtbot/factory_girl) / [Rails](https://github.com/thoughtbot/factory_girl_rails) - Useful tool for building and persisting models for testing
  - [Pry](http://pryrepl.org/) - A very useful tool for debugging

## Enabling PostgreSQL Support
* Install `postgresql`
* Uncomment `gem "pg"` in the Gemfile
* Replace `config/database.yml` with `config/database.postgresql.yml`
* Rename `lib/tasks/database.rake.disable` to `lib/tasks/database.rake`
