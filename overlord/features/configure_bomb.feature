Feature: Villain configures the bomb

  Scenario: Villain boots the bomb with default Values
    Given I am on the "configure_bomb" page
    And I have an unbooted bomb
    Then I should see bomb is unbooted

  Scenario: Villain boots the bomb with default Values
    Given I am on the "configure_bomb" page
    And I have an unbooted bomb
    When I press "Boot Bomb" within "configure_bomb"
    Then I should see "Bomb Status: Booted"
    And I should see "Arming code: 0000"
    And I should see "Disarming code: 1234"
#
  Scenario: Villain sets the bomb arming and disarming codes
    Given I am on the "configure_bomb" page
    And I have an unbooted bomb
    When I enter '2222' for "arming_code"
    And I enter '3333' for "disarming_code"
    And I press "Boot Bomb" within "configure_bomb"
    Then I should see "Bomb Status: Booted"
    And I should see "Arming code: 2222"
    And I should see "Disarming code: 3333"
