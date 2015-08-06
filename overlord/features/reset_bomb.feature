@reset_bomb_codes
Feature: Villain resets arming and disarming codes

Scenario: Villain resets the arming code
  Given I have a booted bomb with default values
  And I am on the "reset_codes" page
  When I enter '7777' for "arming_code_reset"
  And I press "Reset Bomb Codes" within "reset_codes"
  And I should see " Your arming code: 7777"


Scenario: Villain resets the disarming code
  Given I have a booted bomb with default values
  And I am on the "reset_codes" page
  When I enter '8888' for "disarming_code_reset"
  And I press "Reset Bomb Codes" within "reset_codes"
  And I should see " Your disarming code: 8888"


#Scenario: Villain resets the disarming code
#  Given I am on "the reset_bomb page"
#  And the bomb disarming code is configured
#  When I enter '3333' for 'disarming_reset_code'
#  Then I should see "Bomb disarming code has been reset!"
#  And I should see "Arming code is 3333?"