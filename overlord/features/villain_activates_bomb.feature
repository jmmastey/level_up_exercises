Feature: villain activates bomb

  As a villain
  I want to activate the bomb
  So I can blow up stuff

  Scenario: activate the bomb
    Given I am on the start page
    When I fill in "activation_code" with "3333"
    And I press "Arm the bomb"
    Then I should see "Bomb is armed"


