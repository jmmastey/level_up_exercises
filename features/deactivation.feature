Feature: Deactivation Of Bomb
  User should be able to visit a page to activate a bomb. When the user
  either specifies a custom activation code or accepts the default, then the
  bomb will activate.

  Once the bomb is active, user can input the deactivation code and upon
  successfully doing so, the bomb will become inactive and stop counting down.
  If the user enters a incorrect activation code 3 times, then the bomb will
  explode.

  Background:
    Given I have a configured bomb with default codes
    When I activate the bomb with code '1111'
    Then I should see 'Activated'

  Scenario: Deactivate the bomb
    Given I fill in '1234' to deactivate the bomb
    Then I should see 'Deactivated'

  Scenario: Input incorrect deactivation code 3 times
    Given I fill in '5678' to deactivate the bomb
    Given I fill in '9877' to deactivate the bomb
    Given I fill in '3333' to deactivate the bomb
    Then I should see the bomb as 'Exploded'

  Scenario: When a user snips the bomb wire
    Given I snip the wire
    Then I should see 'Deactivated'

  Scenario: When user does not enter deactivation code on activated bomb
    When I do nothing on the deactivation page for 30 seconds
    Then I should see the bomb as 'Exploded'