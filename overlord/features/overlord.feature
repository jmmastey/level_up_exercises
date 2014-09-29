Feature: Create a cool bomb thingy
  User should be able to visit a page to activate a bomb. When the user
  either specifies a custom activation code or accepts the default, then the
  bomb will activate.

  Once the bomb is active, user can input the deactivation code and upon
  successfully doing so, the bomb will become inactive and stop counting down.
  If the user enters a incorrect activation code 3 times, then the bomb will
  explode.

  Scenario: Configure bomb with activation code
    Given Configure bomb with activation codes '1111' and '8888'
    When I fill in '1111' to activate the bomb
    Then I should see 'Activated'

  Scenario: Verify only numeric inputs are accepted
    Given I visit the activation page
    When I fill in '1111' to activate the bomb
    Then I should see 'Activated'
    And I fill in '1111' to activate the bomb again
    Then I should still see the bomb as 'Activated'

  Scenario: Configure bomb with deactivation code
    Given Configure bomb with deactivation codes '2222' and '0000'
    When I fill in '2222' to deactivate the bomb
    Then I should see 'Deactivated'

  Scenario: Input incorrect deactivation code 3 times
    Given I attempt to deactivate the bomb with incorrect activation codes
    When I fill in '3333', '3334' and '3335' to deactivate the bomb
    Then I should see the bomb as 'Exploded'

  Scenario: Exploded Bomb
    Given I blow up the bomb
    When The bomb shows as 'Exploded'
    Then I should not be able to use any of the buttons

  Scenario: Attempting to activate a already activated bomb
    Given I have already activated the bomb
    When I attempt to go back to the activation page
    Then I should see the state of the bomb as 'Activated'

  Scenario: When user does not enter deactivation code on activated bomb
    Given I have activated the bomb
    When I do nothing on the deactivation page for 30 seconds
    Then The bomb should show a state of 'Exploded'