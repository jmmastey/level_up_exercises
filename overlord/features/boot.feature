Feature: I visit the home page
  Background:
    Given I go to the home page /

  Scenario: I visit the home page
    Then the activation and deactivation should have default values
    And I should see "Boot" button
    And I should see the bomb info "The default two codes are used if you don't change"

  Scenario: I boot the bomb with default codes
    When I click "Boot"
    Then I should see the bomb state : "Not Activate"

  Scenario: I boot the bomb with custom codes
    Then I enter the custom activation and deactivation code
    When I click "Boot"
    Then I should see the bomb state : "Not Activate"
