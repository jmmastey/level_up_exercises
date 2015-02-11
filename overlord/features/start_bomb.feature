Feature: Starting a bomb
  Background:
    Given I start the app

  Scenario: Visiting the start page
    Then I should see "Activation Code"
    And I should see "Deactivation code"

  Scenario: Valid activation and deactivation codes
    Given I fill in "Activation Code" with "5678"
    And I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    Then I should be on the "started" page

  Scenario: Invalid activation code
    Given I fill in "Activation Code" with "123a"
    And I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    Then I should see "Invalid activation code"

  Scenario: Invalid deactivation code
    Given I fill in "Activation Code" with "5678"
    And I fill in "Deactivation Code" with "111a"
    And I click "Submit"
    Then I should see "Invalid deactivation code"

  Scenario: No deactivation code
    Given I fill in "Activation Code" with "5678"
    And I click "Submit"
    Then I should be on the "started" page

  Scenario: No activation code
    Given I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    Then I should be on the "started" page