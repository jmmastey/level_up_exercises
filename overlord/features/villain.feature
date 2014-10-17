 Feature: Activate bomb
  As a villain
  I want to activate bomb
  So that I can detonate it

  Scenario: Valid activation
    Given the bomb is inactive
    When I type 2342
    And I press activate
    Then the bomb should be active
