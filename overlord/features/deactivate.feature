Feature: Deactivate
  As a user
  I want to be able to deactivate the bomb
  In order to save the world (cheerleader)

  Scenario: Deactivate the bomb
    Given I am logged in as a villain
    And the bomb is active
    When I use the correct deactivation code
    Then I should see an inactive bomb

  Scenario: Use wrong deactivation code results in active bomb
    Given I am logged in as a villain
    And the bomb is active
    And I use the wrong deactivation code
    Then I should see an active bomb

  Scenario: Use wrong deactivation code results decreased defusal attempts
    Given I am logged in as a villain
    And the bomb is active
    And I use the wrong deactivation code
    Then the number of defusal attempts should decrease
