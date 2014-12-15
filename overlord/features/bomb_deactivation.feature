Feature: Deactivating Bomb Detonation Device
  As a devious Super Villian
  I want to deactivate the bomb detonation device
  So that I don't blow myself up accidentally

Background:
Given I visit the bomb boot up page
When I set the activation code as "1234" and deactivation code as "0000"
And I activate the bomb with code "1234"

Scenario: Deactivate the bomb with correct code
Given I am on the page with text "De-activate - BOMB is now active"
When I deactivate the bomb with code "0000"
Then I should see "Bomb is inactive - configure codes" on the boot page

Scenario Outline: Enter incorrect code for deactivation
Given I am on the page with text "De-activate - BOMB is now active"
When I deactivate the bomb with code "<code>"
Then I should see less than 30 seconds and 2 attempts left message on the page

Examples:
| code  |
| 1111  |
| abc   |
| ab12  |

Scenario: Enter incorrect deactivation code three times
Given I am on the page with text "De-activate - BOMB is now active"
When I try to deactivate the bomb with wrong code "1111" three times
Then I should see "You have exceeded 3 attempts - BOMB exploded!!!" on the bomb page
