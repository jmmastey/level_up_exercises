# TweetMapper

TweetMapper is a Google Maps application that will show tweets by location in real time.

#### Ruby version

2.0.0 or higher

#### System dependencies

**cron** is required for background task scheduling/processing.
Use the included **Gemfile** to ensure your Rails environment is set up to run this app properly. (*bundle update*).

#### Configuration

Bower is used for front end dependencies via the rails-bower gem. Use *rake -T bower* for a list of commands. Rails' Asset Pipeline is used for minification/concatenation.

#### Database creation

Use *bundle install* and then *rake db:migrate". Make sure to run *whenever -w* in order to write background processing to your crontab.

#### How to run the test suite

	bundle exec rspec spec/*
	
We did not do Cucumber integration testing for this application, because Capybara does a poor job of reading and interpretting the Google Map interface (the current UI is 100% Google Maps).

#### Services (job queues, cache servers, search engines, etc.)

Google Maps API, Twitter API

#### Deployment instructions

**puma** recommended. Make sure the database is installed, per the **database creation** instructions.

---

## Roadmap

There's a few things we need to do before this can be deployed for mass usage:

* Create additional Twitter application tokens and build out infrastructure for distributing requests among these various IDs (will allow us to squeeze more requests out of our tight rate limiting with Twitter).
* Add intelligent throttling to the Twitter API calls to service all clients.

Other nice-to-haves:

* Add Twitter avatar images to infowindows.
* Pull any linked images inline to have a preview showing in the infowindows.
