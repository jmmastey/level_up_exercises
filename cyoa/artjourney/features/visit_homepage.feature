Feature: Visiting Homepage

  Scenario: User visits homepage
    Given I am on the homepage
    Then I should see a link to the artists page
    And a login button
    And a signup button
