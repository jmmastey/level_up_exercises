Feature: My Feeds Page
  As a registered user
  I want to have a "My Feeds" page that shows the custom feeds I have defined
  and those which are available to me
  So that I have a custom home page giving context regarding the use of the service

@ignore
Scenario: Find custom feeds list
  Given I am an authenticated user viewing the "My Feeds" page
  Then I see a heading for "My Custom Feeds"
  And I see a link for "Create New Feed"

@ignore
Scenario: Find user-authorized feeds list
  Given I am an authenticated user viewing the "My Feeds" page
  Then I see a heading for "Shared With Me"

@ignore
Scenario: Find public feeds list
  Given I am an authenticated user viewing the "My Feeds" page
  Then I see a heading for "Public"

@ignore
Scenario: Find feed-search interface
  Given I am an authenticated user viewing the "My Feeds" page
  Then I see a heading for "Search for Feeds"
