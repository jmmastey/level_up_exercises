Feature: Booting up Bomb Detonation Device

Scenario: Boot up the bomb
Given I visit the bomb boot up page
When I type in the activation code "123" and deactivation code "456"
And I click the confirm button
Then I should see "Activate - BOMB is inactive" on the bomb page

Scenario Outline: Do not allow alphabets for activation and deactivation code
Given I visit the bomb boot up page
When I type in the activation code "<activate>" and deactivation code "<deactivate>"
And I click the confirm button
Then I should see "Enter only numeric values." on the boot page

Examples:
| activate | deactivate |
| abc      | def        |
| abc      | 456        |
| 123      | def        |

Scenario: Set default codes when no values are provided
Given I visit the bomb boot up page
When I type in the activation code "" and deactivation code ""
And I click the confirm button
Then I should see "Activate - BOMB is inactive" on the bomb page


