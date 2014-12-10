Feature: Activating Bomb Detonation Device

Background:
Given I visit the bomb boot up page
And I type in the activation code "1234" and deactivation code "0000"
And I click the confirm button

Scenario: Activate the bomb with correct code
Given I am on the page with text "Activate - BOMB is inactive"
When I type activation code "1234"
And I click the confirm button
Then I should see "De-activate - BOMB is now active" on the bomb page

Scenario: Enter incorrect code for activation
Given I am on the page with text "Activate - BOMB is inactive"
When I type activation code "abcd"
And I click the confirm button
Then I should see "Incorrect activation code" on the bomb page
