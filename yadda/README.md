## Setup

```ruby
ruby yadda_generator.rb
```

This drops the yadda database, recreates it, creates the tables, and then seeds them. You should only run this once and never again.

# YADDA - Yet Another Drinking Diary App

We need an excuse to build a database with some real interactions. This is just that excuse. There is a major flaw with every currently extant drinking-diary app (BrewTrackr, BrewGene, Untappd, BeerHunt, NextPint, etc etc etc). They've all already been built, and not by us. Let's use that justification and build some data.

The different parts of this exercise correspond with an entire module on Data, so don't feel the need to do them all up front.

## Part 1 - Build A Schema

Build and define a schema to track users' drink history, so that they can remember which drinks they enjoyed the most. Make sure to use the right column types and sizes, as well as good names. Some of the entities you'll need to track:

* Brewery - The group that makes a set of beers. They have a name and address, as well as a description and a founding year.
* Beer - A single type of brew from a brewery. Includes a style, description, and brewing year.
* User - A person who drinks beer. Give them some humany fields.
* Rating - When a person drinks a beer, they should be able to rate it on some parameters. Look at a site like [Beer Advocate](http://www.beeradvocate.com/beer/profile/26/7520/) for details.
* All entities need some mechanical fields for insertion / update times and updater / inserter info.
* Make sure to maintain referential integrity and proper cascading.

Build the set of `CREATE TABLE` and related SQL statements to generate a proper, commented schema for this section.

## Part 2 - Views

We're going to play with some larger data and start to organize it at the database level so that it can be retrieved. First, write some `INSERT`, `UPDATE` and `DELETE` statements for your tables to show how to populate data into them. Now recognize that nobody really does that by hand anymore and write a little ruby script to insert a bunch of data into the system for you. A million drinks over maybe 200,000 drinkers should suffice.

Now let's retrieve some data. Write the `CREATE VIEW` statements to generate the following information from your source data:

* Top beers from a given brewery, according to their total ratings.
* "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged.
* "You might also enjoy", which picks beers of the same style with high average scores, and then sorts them randomly.

## Part 3 - Troubleshooting Performance with Explain

So it turns out those queries are not terribly performant, huh? Not a big surprise, transforming all that data on the fly is more than a little bit of a pain. Use the `EXPLAIN` command to get a detailed report on exactly how bad they are. Explain the output of the queries and suggest any improvements you see based on that output.

## Part 4 - Build Some Indices

Into the home stretch here; use the view queries and the `EXPLAIN` output to suggest some good indices to add to the tables. Write the appropriate `CREATE INDEX` statements and then use `EXPLAIN` to justify that they worked as you expected. Two caveats here:

* For performance reasons, we would need something a bit more complicated than just a `CREATE INDEX` for large production datasets.
* Postgres might choose to use your index or not based on the random data you generated. The more realistic your "development" dataset is, the more you'll know about how it performs in production.
