== Travel Planner

The travel planner helps plan business travel to remote locations. Given a meeting date and time, along with home and destination, it picks the best flights for you using the FlightStats API.

It's a rails app with postgres as the database. I run windows, this works on ruby 2.1.3p242 (2014-09-19 revision 47630) [i386-mingw32].

`bundle install`

For anything to work, the db/seeds.db must be run - this creates the two airports used in the tests. Without these, pretty much nothing (even production) will work at this point.

`bundle exec rake db:seed`

For testing, it uses rspec, cucumber, and vcr to mock 95% of the remote API calls. Note that in the FlightStats API tests, there are only a few remote calls that are made, and even those are only made once per day, then the response reused if you run the tests again (see the spec/cassettes directory).

`bundle exec rspec`

`bundle exec cucumber`

Start it up....

`bundle exec rails server`
