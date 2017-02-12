Feature: Activating the Bomb

Scenario: Use default activation code to activate bomb
  Given I am using the default codes
  When I enter the default activation code
  Then the bomb should be active state

Scenario: Use custom activation code to activate bomb
  Given I am using the custom codes
  When I enter the custom activation code
  Then the bomb should be active state
 