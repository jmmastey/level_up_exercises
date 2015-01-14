Feature: Anonymous (unauthenticated) user page 
  As an unauthenticated user checking out the site
  I want to see some example, topical calendar feeds, a user registration
    link, and general site information
  To interest me in using the site to keep apprised events in Chitown

Scenario: Main site page shows highlights from topical feeds
  Given I am an unauthenticated user visiting the "Home" page
  Then I see a heading for "Chicago Highlights"
  And I see a feed highlight for "Opening Night Calendar"
  And I see a feed highlight for "Meetups"

Scenario: Main site page shows some topical feed options
  Given I am an unauthenticated user visiting the "Home" page
  Then I see a menu for "I Like To"
  And I see a feed category for "Theater"
  And I see a feed category for "Music"
  And I see a feed category for "Comedy"

Scenario: Main site page shows new user registration link
  Given I am an unauthenticated user visiting the "Home" page
  Then I see a link to "Sign up"

Scenario: Main site page shows About Us link
  Given I am an unauthenticated user visiting the "Home" page
  Then I see a menu link to "About Us"

Scenario: Main site page shows Private Policy link
  Given I am an unauthenticated user visiting the "Home" page
  Then I see a menu link to "Privacy Policy"

Scenario: Main site page shows Contact Us link
  Given I am an unauthenticated user visiting the "Home" page
  Then I see a menu link to "Contact Us"
