Feature: User visits the home page
  In order to sign in/sign up/view achievements of congress
  As a user
  I want to visit the homepage

  Background:
    Given I am not logged in
      And I visit Home page

  Scenario: Sees navigational links
    Then I see Good Deeds link
      And I see Bills link
      And I see Legislators link
      And I see Search link

  # Scenario: Sees login and signup links
  #   Then I see Login link
  #     And I see Signup link


  # Scenario Outline: Clicks each link to go to that page
  #   When I click <link> link
  #   Then I am on <link> page

  #   Examples:
  #   | link        |
  #   | Good Deeds  |
  #   | Bills       |
  #   | Legislators |
  #   | Search      |
  #   | Login       |
  #   | Signup      |



