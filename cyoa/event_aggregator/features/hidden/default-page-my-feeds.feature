Feature: Default Login Page is My Feeds
  As a user who has just logged in
  I want to land on My Feeds page
  Because it is at least as good a place as any

@ignore
Scenario: Login an land of My Feeds page
  Given I am an unauthenticated user
  When I log in
  I see the "My Feeds" page
