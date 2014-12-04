Feature: Visiting Static Pages

  Scenario: User visits homepage
    Given I am on the homepage
    Then I should see a link to the Artists page
    And a Login button
    And a Signup button

  Scenario: User visits artists page
    Given I am on the homepage
    When I click on Artists
    Then I should be on the Artists page

  Scenario: User visits signup page
    Given I am on the homepage
    When I click on Signup
    Then I should be on the Signup page

  Scenario: User visits login page
