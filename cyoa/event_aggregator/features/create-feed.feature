Feature: Create new feed
  As an authenticated user interested in specific types of events
  I want to compose a calendar feed of specific types of events
  So I can receive focused information tailored to my own interests

@ignore
Scenario: Create-feed link
  Given I am an authenticated user viewing the "My Feeds" Page
  Then I see a link for "Create new feed"
  
@ignore
Scenario: Access create-feed page
  Given I am an authenticated user viewing the "My Feeds" Page
  When I click the link for "Create new feed"
  Then I see the "Create new feed" page

@ignore
Scenario: Unauthenticated user can not access create=feed page
  Given I am an unauthenticated user
  When I attempt to view the "Create new feed" page
  Then I see an HTTP 401 (Unauthorized) error page

@ignore
Scenario: Create new feed from specific data source
  Given I am viewing the "Create new feed" page
  When I set new feed title to "Test From Opening Night Calendar"
  And I add data source "Opening Night Calendar" to the data source selector
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "Test From Opening Night Calendar"

@ignore
Scenario: Create new feed from two data sources
  Given I am viewing the "Create new feed" page
  When I set new feed title to "Test From ONC and Meetups"
  And I add data source "Opening Night Calendar" to the data source selector
  And I add data source "Meetups" to the data source selector
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "Test From ONC and Meetups"

@ignore
Scenario: Create new feed restricted by tag rule
  Given I am viewing the "Create new feed" page
  When I set new feed title to "Test By Tag"
  And I add tag "theater" to the tag selector
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "Test By Tag"

@ignore
Scenario: Create new feed restriced by keyword rule
  Given I am viewing the "Create new feed" page
  When I set new feed title to "Test by keyword"
  And I enter text "blue man group" in the keyword search input
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "Test by keyword"

@ignore
Scenario: Create new feed restricted by day-of-week rule
  Given I am viewing the "Create new feed" page
  When I set new feed title to "Thursday only"
  And I select "Thursday" from the day-of-week input
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "Thursday only"

@ignore
Scenario: Create new feed restricted by date-range rule
  Given I am viewing the "Create new feed" page
  When I set new feed title to "December Events"
  And I select date range "12/1/2014" to "12/31/2014"
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "December Events"

@ignore
Scenario: Create feed including events from authorized feed
  Given I am viewing the "Create new feed" page
  When I set new feed title to "My Friends Events"
  And I add feed "my special events" owned by user "my_friend"
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "My Friends Events"

@ignore
Scenario: Create feed including events from public feed
  Given I am viewing the "Create new feed" page
  When I set new feed title to "Republished public feed"
  And I add public feed "Blue Man Group"
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "Republished public feed"

@ignore
Scenario: Create feed including events from my own feed
  Given I am viewing the "Create new feed" page
  And I have a custom feed called "Thursdays"
  And I have a custom feed called "Fridays"
  When I set new feed title to "Thursdays and Fridays"
  And I add my custom feed "Thursdays"
  And I add my custom feed "Fridays"
  And I press the "create feed" button
  Then I see the "show-feed" page for feed "Thursdays and Fridays"
