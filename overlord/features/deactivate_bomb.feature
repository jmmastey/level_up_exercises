Feature: villain tries to deactivate an activated bomb
  
  As a villain
  I want to be able to deactivate a bomb
  So that I can avoid blowing up at the wrong time

  Background:
    Given a bomb has been activated

  Scenario: Deactivate Bomb
    When I deactivate the bomb
    Then I should see "Bomb has been deactivated"
    And I should be able to reactivate the bomb

  Scenario: Villain tries to deactivate a bomb incorrectly
    When I try to deactivate the bomb incorrectly
    Then I should be warned that my activation code is incorrect
    And I should be warned the number of incorrect attempts

  Scenario: Villain tries to deactivate a bomb 3 times incorrectly
    When I try to deactivate the bomb 3 times incorrectly
    Then the bomb should explode
