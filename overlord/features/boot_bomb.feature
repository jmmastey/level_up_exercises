Feature: Villain boots bomb with and without codes

  Scenario: Villain boots the bomb with default Values
    Given I am on the "villain" page
    And I have an unbooted bomb
    Then I should see bomb is unbooted

  Scenario: Villain boots the bomb with default Values
    Given I am on the "boot_bomb" page
    And I have an unbooted bomb
    When I press "Boot Bomb" within "boot_bomb"
    Then I should see "Bomb Status: Booted" within "villain"
    And I should see "Your arming code: 0000" within "villain"
    And I should see "Your disarming code: 1234" within "villain"

  Scenario: Villain sets the bomb arming code with values
    Given I am on the "boot_bomb" page
    And I have an unbooted bomb
    When I enter '2222' for "arming_code"
    And I enter '3333' for "disarming_code"
    And I press "Boot Bomb" within "boot_bomb"
    Then I should see "Bomb Status: Booted" within "villain"
    And I should see "Your arming code: 2222" within "villain"
    And I should see "Your disarming code: 3333" within "villain"
