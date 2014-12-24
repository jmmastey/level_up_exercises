Feature: My Feeds Page
  As a registered user
  I want to have a "My Feeds" page that shows the custom feeds I have defined
  and those which are available to me
  So that I have a custom home page giving context regarding the use of the service


Scenario: Find create new feed menu link
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a menu link for "Create New Feed"

Scenario: Find custom feeds list
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a heading for "My Custom Feeds"

Scenario: Find public feeds list
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a heading for "Public Feeds"

Scenario: Find feed-search interface
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a menu link for "Search for Feeds"
