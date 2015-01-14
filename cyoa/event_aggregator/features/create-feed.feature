Feature: Create new feed
  As an authenticated user interested in specific types of events
  I want to compose a calendar feed of specific types of events
  So I can receive focused information tailored to my own interests

Scenario: Create-feed link
  Given I am an authenticated user visiting the "My Feeds" page
  Then I see a link for "Create new feed"

Scenario: Access create-feed page
  Given I am an authenticated user visiting the "My Feeds" page
  When I click the link for "Create new feed"
  Then I see the "Create new feed" page


Scenario: Unauthenticated user can not access Create new feed page
  Given I am an unauthenticated user
  When I visit the "Create new feed" page
  Then I see the "login" page

Scenario: Create new feed goes to Editing Page
  Given I am an authenticated user visiting the "Create new feed" page
  When I type "Test From Opening Night Calendar" into the "Feed Title" field
  And I type "This is a feed" into the "Feed Description" field
  And I press the "Next..." button
  Then I see the "Edit feed" page

Scenario: Cancel feed creation returns to My Feeds page
  Given I am an authenticated user visiting the "Create new feed" page
  When I type "Test From Opening Night Calendar" into the "Feed Title" field
  And I type "This is a feed" into the "Feed Description" field
  And I press the "Cancel" button
  Then I see the "My Feeds" page
