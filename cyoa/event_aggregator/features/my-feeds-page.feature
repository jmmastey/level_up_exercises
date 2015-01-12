Feature: My Feeds Page
  As a registered user
  I want to have a "My Feeds" page that shows the custom feeds I have defined
  and those which are available to me
  So that I have a custom home page giving context regarding the use of the service

Scenario: Find create new feed command
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a command for "Create new feed"

Scenario: Find feed-search command
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a command for "Search for feeds"

Scenario: Find custom feeds list
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a heading for "My Custom Feeds"

@ignore
Scenario: Custom feeds list has custom feeds
  #Given I am a registered user "Anne"
  #And I have 3 custom feeds
  Then FIXME

Scenario: Find public feeds list
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a heading for "Public Feeds"

@ignore
Scenario: Public feeds list has public feeds
  Then FIXME
