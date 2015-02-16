Feature: Bomb State Routing

  Scenario: Accessing the bomb activation page
    Given A bomb has already been activated
    When I am on the bomb activation page
    Then I should not be on bomb activation page

  Scenario: Accessing the bomb creation page
    Given A bomb has already been armed
    When I am on the bomb creation page
    Then I should not be on bomb creation page

  Scenario: Accessing the bomb disarming page
    Given A bomb has already been disarmed
    When I am on the bomb disarming page
    Then I should not be on bomb disarming page

  Scenario: Accessing the bomb detonated page
    Given A bomb has already been detonated
    When I am on the bomb detonated page
    Then I should be on bomb detonated page
