Feature: Resetting the bomb
  Background: Bomb has been activated
    Given I start the app
    And I fill in "Activation Code" with "5678"
    And I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    And I fill in "Activation Code" with "5678"
    And I click "Submit"

  Scenario: after deactivation
    Given I fill in "Deactivation Code" with "1111"
    And I click "Submit"
    When I click link "Start another bomb"
    Then I should be on the "index" page

  Scenario: after explosion
    Given I fill in "Deactivation Code" with "2222"
    And I click "Submit"
    And I fill in "Deactivation Code" with "2222"
    And I click "Submit"
    And I fill in "Deactivation Code" with "2222"
    And I click "Submit"
    When I click link "Start another bomb"
    Then I should be on the "index" page