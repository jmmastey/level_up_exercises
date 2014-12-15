Feature: Booting up Bomb Detonation Device
  As a devious Super Villian
  I want to boot up my bomb detonation device
  So that I can activate and deactivate at will

Scenario: Boot up the bomb
Given I visit the bomb boot up page
When I set the activation code as "123" and deactivation code as "456"
Then I should see "Activate - BOMB is inactive" on the bomb page

Scenario Outline: Do not allow alphabets for activation and deactivation code
Given I visit the bomb boot up page
When I set the activation code as "<activate>" and deactivation code as "<deactivate>"
Then I should see "Enter only numeric values." on the boot page

Examples:
| activate | deactivate |
| abc      | def        |
| abc      | 456        |
| 123      | def        |

Scenario: Set default codes when no values are provided
Given I visit the bomb boot up page
When I set the activation code as "" and deactivation code as ""
Then I should see "Activate - BOMB is inactive" on the bomb page


