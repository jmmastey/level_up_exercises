Feature: Deactivating Bomb Detonation Device

Background:
Given I visit the bomb boot up page
And I type in the activation code "1234" and deactivation code "0000"
And I click the confirm button
And I type activation code "1234"
And I click the confirm button

Scenario: Deactivate the bomb with correct code
Given I am on the page with text "De-activate - BOMB is now active"
When I type deactivation code "0000"
And I click the confirm button
Then I should see "Bomb is inactive - configure codes" on the boot page

Scenario Outline: Enter incorrect code for deactivation
Given I am on the page with text "De-activate - BOMB is now active"
When I type deactivation code "<code>"
And I click the confirm button
Then I should see less than 30 seconds and 2 attempts left message on the page

Examples:
| code  |
| 1111  |
| abc   |
| ab12  |

Scenario: Enter incorrect deactivation code three times
Given I am on the page with text "De-activate - BOMB is now active"
When I type deactivation code "1111"
And I click the confirm button
And I click the confirm button
And I click the confirm button
Then I should see "You have exceeded 3 attempts - BOMB exploded!!!" on the bomb page
