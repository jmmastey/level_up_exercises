 Feature: Activate bomb
  As a villain
  I want to activate bomb
  So that I can detonate it

  Scenario: Valid activation
    Given the bomb is inactive
    When I type 2342
    And I press activate
    Then the bomb should be active

   Scenario: Invalid activation
    Given the activation code is 2342
    When I type 5555
    And I press activate
    Then the bomb should be inactive