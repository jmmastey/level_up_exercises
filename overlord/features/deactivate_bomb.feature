Feature: Activating a bomb
  Background: Bomb has already been started and activated
    Given I start the app
    And I fill in "Activation Code" with "5678"
    And I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    And I fill in "Activation Code" with "5678"
    And I click "Submit"

  Scenario: Valid deactivation code
    When I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    Then I should be on the "deactivated" page

  Scenario: Invalid deactivation code
    When I fill in "Deactivation Code" with "2222"
    And I click "Submit"
    Then I should see "2 attempts left"

  Scenario: Invalid deactivation code third attempt
    Given I fill in "Deactivation Code" with "2222"
    And I click "Submit"
    And I fill in "Deactivation Code" with "2222"
    And I click "Submit"
    And I fill in "Deactivation Code" with "2222"
    And I click "Submit"
    Then I should be on the "exploded" page