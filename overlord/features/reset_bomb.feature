Feature: Villain resets arming and disarming codes

Scenario: Villain resets the arming code
  Given I have a booted bomb with default values
  And I am on the "configure_bomb" page
  When I enter '7777' for "arming_code_reset"
  And I press "Reset Bomb Codes" within "configure_bomb"
  And I should see "Arming code: 7777"


Scenario: Villain resets the disarming code
  Given I have a booted bomb with default values
  And I am on the "configure_bomb" page
  When I enter '8888' for "disarming_code_reset"
  And I press "Reset Bomb Codes" within "configure_bomb"
  And I should see "Disarming code: 8888"


Scenario: Villain resets the arming and disarming code
  Given I have a booted bomb with default values
  And I am on the "configure_bomb" page
  When I enter '7777' for "arming_code_reset"
  And I enter '8888' for "disarming_code_reset"
  And I press "Reset Bomb Codes" within "configure_bomb"
  And I should see "Arming code: 7777"
  And I should see "Disarming code: 8888"