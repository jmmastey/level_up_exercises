# Find Me A Sandwich

I'm hungry and could use a sandwich.  However, I have no idea what type of sandwich I want, or from where.

<a href="http://xkcd.com/149/" target="xkcd"><img src="http://imgs.xkcd.com/comics/sandwich.png" alt="xkcd - Make me a sandwich" /></a>

We have a pretty basic app calle "Find Me A Sandwich" which can lookup menus from different restaurants.  However, it doesn't let me save my favorite sandwiches for later, or let me look up others' favorites.

Your job is to allow me to favorite my sandwiches, and look up the favorites of others.

## Table of Contents
* [The Exercise](#the-exercise)
  - [Part 0 - Getting Started](#part-0---getting-started)
  - [Part 1 - Behavioral Tests](#part-1---behavioral-tests)
  - [Part 2 - Views](#part-2---views)
  - [Part 3 - Controller](#part-3---controller)
  - [Part 4 - Model](#part-4---model)
  - [Part 5 - API](#part-5---api)
* [Enabling PostgreSQL Support](#enabling-postgresql-support)

## The Exercise

### Part 0 - Getting Started
First, you'll need to get everything set up.  Run the tests with `bundle exec cucumber` and `bundle exec rspec` and make sure everything passes.  Then stand the app up and make sure you can navigate it in your browser.

### Part 1 - Behavioral Tests
As with any behavior-driven developed program, you'll be starting with the tests.  Add a series of Cucumber features for favoriting/unfavoriting meals, and looking up others' favorites.

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

### Part 2 - Views
Now that we have some behavioral tests up, let's add some views.  Use Haml to modify the existing menu and add a "Favorite" option to each menu item. Also add views to:
* View and manage your favorites
* Browse others' favorites

### Part 3 - Controller
Now let's add a controller to receive requests related to our favorites and respond with the appropriate rendered view.  Start with some [specs](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs). Then add the controller itself.

### Part 4 - Model
Finally, we need to create the Favorite model and appropriate database migration.  The model should reference a `User` and a `MenuItem`.

**Bonus points:** Use PostgreSQL for the database instead of SQLite. See section below on [*Enabling PostgreSQL Support*](#enabling-postgresql-support).

### Part 5 - API
This site's search capabilities aren't very useful.  I want to be able to search restaurants by menu item.  We've got developers working on the interface, but we need someone to update the Locu API client library.  Take a look at the [Locu docs](https://dev.locu.com/documentation/#venue-search-api) and update `Locu::Client#search_venues` to support searching by menu items.

## Enabling PostgreSQL Support
* Install `postgresql`
* Uncomment `gem "pg"` in the Gemfile
* Replace `config/database.yml` with `config/database.postgresql.yml`
* Rename `lib/tasks/database.rake.disable` to `lib/tasks/database.rake`
