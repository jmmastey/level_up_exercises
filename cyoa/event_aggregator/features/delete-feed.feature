Feature: Delete custom feed
  As a capricious user who no longer needs feeds I created
  I want to delete unneeded feeds
  So they don't hang around and clutter my view

Background:
  Given I am an authenticated user
  And I have a custom feed "Thursdays"
  And there is a public feed "Blue Man Group"
  And there is a user "X"
  And user "X" owns a feed "User X Feed"
  And user "X" authorized me to view feed "User X Feed"

@ignore
Scenario: Find delete feed link per my own feed item in feed list view
  Given I am viewing the "My Feeds" page
  When I search for my custom feed "Thursdays"
  Then I see a link for "Delete feed" in the feed list item

@ignore
Scenario: Delete feed unavailable for user-authorized feed in feed list view
  Given I am viewing the "My Feeds" page
  When I search for shared feed "User X Feed"
  Then I do not see a link for "Delete feed" in the feed list item

@ignore
Scenario: Delete feed unavailable for public feed in feed list view
  Given I am viewing the "My Feeds" page
  When I search for public feed "Blue Man Group"
  Then I do not see a link for "Delete feed" in the feed list item

@ignore
Scenario: Find delete feed link in show feed view for my own feed
  Given I am viewing the "view-feed" page for "Thursdays"
  Then I see a link for "Delete feed" 

@ignore
Scenario: Delete feed unavailable in show feed view for public feed
  Given I am viewing the "view-feed" page for "User X Feed"
  Then I do not see a link for "Delete feed"

@ignore
Scenario: Delete feed unavailable in show feed view for user-authorized feed
  Given I am viewing the "view-feed" page for "Blue Man Group"
  Then I do not see a link for "Delete feed"

@ignore
Scenario: Find delete feed link in edit feed view for my own feed
  Given I am viewing the "edit-feed" page for "Thursdays"
  Then I see a link for "Delete feed" 

@ignore
Scenario: Delete feed asks for confirmation
  Given I am viewing my custom feed "Thursdays"
  When click the "Delete feed" link
  Then I see a confirmation dialog for 'Delete "Thursdays"?'

@ignore
Scenario: Delete feed with negative confirmation retains feed
  Given I am viewing my custom feed "Thursdays"
  When click the "Delete feed" link
  And I click the "Cancel" button
  Then I see the "view-feed" page for "Thursdays"

@ignore
Scenario: Delete feed with positive confirmation from "list-feeds" view
  Given I am viewing my custom feeds on the "list-feeds" page
  And I see my custom feed "Thursdays"
  When I click the "Delete feed" link
  And I click the "Delete" button
  Then I see the my custom feeds list
  And I do not see a feed item for "Thursdays"

@ignore
Scenario: Failure on attempt to delete user-authorized feed
  When I access the delete feed operation for shared feed "User X Feed"
  Then I receive HTTP error 403
  And I see flash message "You are not allowed to delete this feed"

@ignore
Scenario: Failure on attempt to delete public feed
  When I access the delete feed operation for public feed "Blue Man Group"
  Then I receive HTTP error 403
  And I see flash message "You are not allowed to delete this feed"

