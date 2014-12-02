Feature: List available feeds
  As any user
  I want to search for and list available feeds
  So I can learn all the feeds that may access

Scenario: Find feed search link on main page
  Given I am viewing the "Anonymous Page"
  Then I see a heading for "Search for Feeds"

Scenario: Find filter to include my own feeds in list
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Include My Custom Feeds"

Scenario: List my own feeds
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I activate the "Include My Custom Feeds" input control
  And I click the "Search" button
  Then the search result contains my custom feeds

Scenario: Find filter to include public feeds
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Include Public Feeds"

Scenario: List public feeds
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I activate the "Include Public Feeds" input control
  And I click the "Search" button
  Then the search result contains public feeds

Scenario: Find filter to include user-authorized feeds
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Include Shared Feeds"

Scenario: List authorized feeds
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I activate the "Include Shared Feeds" input control
  And I click the "Search" button
  Then the search result contains my shared feeds

Scenario: List public, authorized, and my own feeds together
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I active the "Include My Custom Feeds" input control
  And I active the "Include Public Feeds" input control
  And I active the "Include Shared Feeds" input control
  And I click the "Search" button
  Then the search result contains my custom feeds
  And the search result contains public feeds
  And the search result contains my shared feeds

Scenario: Find filter to search by title
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Search Feed Titles"

Scenario: List feeds by title
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I enter a title keywords "FOO BAR" into the "Search Feed Titles" control
  And I click the "search button"
  Then the search result contains feeds with "FOO" or "BAR" in the titleyy

Scenario: Find filter to search by owner user
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Search by Owner"
  
Scenario: List user-authorized feeds by owner user
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I enter users "FOO BAR" into the "Search by Owner" control
  And I click the "search button"
  Then the search result contains shared feeds with owners named "FOO" or "BAR"

Scenario: Non-authorized user feeds are not available
  Given I am an authenticated user viewing the "Search for Feeds" page
  And there is a feed called "FOOFEED" owned by user "X" that is not shared with me
  When I enter user "X" into the "Search by Owner" control
  And I click the "search button"
  Then the search result does not contain a feed called "FOOFEED"

Scenario: Find filter to search by sharing user
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Search Feeds I Share"

Scenario: Search for feed I own by sharing user
  Given I am an authenticated user viewing the "Search for Feeds" page
  And I own feeds called "BARFEED" and "BAZFEED"
  And my feed "BARFEED" is shared with user "X"
  And my feed "BAZFEED" is not shared with user "X"
  When I enter user "X" into the "Search Feeds I Share" input control
  And I click the "search button"
  Then the search result contains feed "BARFEED"
  And the search result does not contain feed "BAZFEED"

Scenario: Search-by-sharing-user does not show feeds owned by another user
  Given I am an authenticated user viewing the "Search for Feeds" page
  And I own a feed called "BARFEED"
  And feed "BARFEED" is shared with user "X"
  And user "Y" owns a feed called "BAZFEED"
  And feed "BAZFEED" is shared with user "X"
  When I enter user "X" into the "Search Feeds I Share" input control
  And I click the "search button"
  Then the search result contains feed "BARFEED"
  And the search result does not contain feed "BAZFEED"

Scenario: Find filter to search by keywords in description
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Search Description"

Scenario: Search for feed by keywords in description
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I enter "FOO BAR" into the input control for "Search Description"
  And I click the "search button"
  Then the search result contains a feed with description containing "FOO"
  And the search result contains a feed with description containing "BAR"

Scenario: Find filter to search by tags
  Given I am an authenticated user viewing the "Search for Feeds" page
  Then I see an input control for "Search Tags"

Scenario: Search for feed by tag inclusion
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I enter "FOO BAR" into the input control for "Search Tags"
  And I click the "search button"
  Then the search result contains a feed with tag "FOO"
  And the search result contains a feed with tag "BAR"

Scenario: Zero-result search
  Given I am an authenticated user viewing the "Search for Feeds" page
  When I enter "USER_DOES_NOT_EXIST" into the input control for "Search by Owner"
  And I click the "search button"
  Then the search result shows "No feed matches these search criteria"
