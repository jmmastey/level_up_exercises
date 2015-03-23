Feature: Evil mastermind wants to config a bomb,
activate the bomb, and deactivate the bomb

Background:
  Given I am on the home page
  When I use '6789' as a act code, '9876' as a deact code
  Then I land on the Activate page
  When I enter '6789' to activate the bomb
  Then My bomb is activated and I have '3' attempts to disarm

Scenario: Mastermind Lands on the main page and uses the custom codes deactivates 1st time
  When I enter '9876' as my deactivation code '1' times
  Then The bomb is deactivated and I can config a new one

Scenario: Mastermind Lands on the main page and uses the custom codes deactivates 2nd time
  When I enter '0001' as my deactivation code '1' times
  Then My bomb is activated and I have '2' attempts to disarm
  When I enter '9876' as my deactivation code '1' times
  Then The bomb is deactivated and I can config a new one

Scenario: Mastermind Lands on the main page and uses the custom codes deactivates 3rd time
  When I enter '0001' as my deactivation code '2' times
  Then My bomb is activated and I have '1' attempts to disarm
  When I enter '9876' as my deactivation code '1' times
  Then The bomb is deactivated and I can config a new one
