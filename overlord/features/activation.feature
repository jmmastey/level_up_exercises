Feature: Activation Of Bomb
  User should be able to visit a page to activate a bomb. When the user
  either specifies a custom activation code or accepts the default, then the
  bomb will activate.

  Once the bomb is active, user can input the deactivation code and upon
  successfully doing so, the bomb will become inactive and stop counting down.
  If the user enters a incorrect activation code 3 times, then the bomb will
  explode.

  Background:
    Given I have a configured bomb with default codes

  Scenario: Activate the bomb
    Given I activate the bomb with code '1111'
    Then I should see 'Activated'

  Scenario: Input incorrect activation code 3 times
    Given I activate the bomb with code '6666'
    Given I activate the bomb with code '6667'
    Given I activate the bomb with code '6668'
    Then I should see the bomb as 'Exploded'

  Scenario: Attempting to activate a already activated bomb
    Given I activate the bomb with code '1111'
    Then I should see 'Activated'
    Given I visit the configuration page
    Then I should see 'Activated'