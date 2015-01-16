Feature: User visits the home page
  In order to sign in/sign up/view achievements of congress
  As a user
  I want to visit the homepage

  Background:
    Given I am not logged in
      And I am on Home page

  Scenario: Sees navigational links
    Then I see Good Deeds link in topbar
      And I see Bills link in topbar
      And I see Legislators link in topbar
      And I see Search link in topbar

  Scenario: Sees login and signup links
    Then I see Log in link in topbar
      And I see Sign up link in topbar

  Scenario Outline: Clicks each link to go to that page
    When I click <link> link in topbar
    Then I should be on <link> page

    Examples:
    | link        |
    | Good Deeds  |
    | Bills       |
    | Legislators |
    | Search      |
    | Log in      |
    | Sign up     |




