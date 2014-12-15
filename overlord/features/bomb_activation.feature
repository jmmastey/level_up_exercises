Feature: Activating the bomb
  As a devious Super Villian
  I want to activate a bomb device
  So that I can bring ultimate destruction

Background:
  Given I visit the bomb boot up page
  When I set the activation code as "1234" and deactivation code as "0000"

Scenario: Activate the bomb with correct code
  Given I am on the page with text "Activate - BOMB is inactive"
  When I activate the bomb with code "1234"
  Then I should see "De-activate - BOMB is now active" on the bomb page

Scenario: Enter incorrect code for activation
  Given I am on the page with text "Activate - BOMB is inactive"
  When I activate the bomb with code "abcd"
  Then I should see "Incorrect activation code" on the bomb page
