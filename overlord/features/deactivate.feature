  Feature: Deactivate bomb
    As a bomb squad member
    I want to deactivate bomb
    So that I can stop an explosion
    
  Scenario: Valid Deactivation
    Given the password is 0000
    And I type 0000
    And I press activate
    And I press deactivate
    Then the bomb should be inactive

  Scenario: Invalid Deactivation
    Given the password is 0000
    And I type 0000
    And I press activate
    And I type 8765
    And I press deactivate
    Then the bomb should be active

  Scenario: Multiple Invalid Deactivation Attempts Triggers Explosion
    Given the password is 0000
    And I type 8765
    And I press deactivate
    And I type 9111
    And I press deactivate
    And I type 0629
    And I press deactivate
    Then the bomb should explode