Feature: Visiting Static Pages

  Scenario: User visits homepage
    Given I am on the homepage
    Then I should see a link to the artists page
    And a login button
    And a signup button

  Scenario: User visits artists page
    Given I am on the homepage
    When I click on Artists
    Then I should be on the artists page

  Scenario: User visits signup page

  Scenario: User visits login page
