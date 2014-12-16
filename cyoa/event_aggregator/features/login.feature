Feature: Log in to the application as a registered user
  As a registered user
  I want to log in
  So I can access personalized content and authorized features

Scenario: Find the login form on unauthenticated top banner
  Given I am an unauthenticated user visiting the "home" page
  Then I see a login form

Scenario: Successful authentication shows user-centric content
  Given I have a registered user "Jack"
  And I authenticate as "Jack"
  Then I see text "Jack Kcajsohn"
  And I see a link for "Not this person"
  And I see a menu link for "My Feeds"

Scenario: Unsuccessful authentication shows anonymous content
  Given I fail to authenticate as "Jack"
  Then I see the "login" page
