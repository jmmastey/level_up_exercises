@overlord

Feature: Create a cool bomb thingy
  User should be able to visit a page to activate a bomb. When the user
  either specifies a custom activation code or accepts the default, then the
  bomb will activate.

  Once the bomb is active, user can input the deactivation code and upon
  successfully doing so, the bomb will become inactive and stop counting down.
  If the user enters a incorrect activation code 3 times, then the bomb will
  explode.

  Background:
    Given I visit the configuration page

  Scenario: Activate the bomb
    Given Configure bomb with codes '1111' and '8888'
    When I activate the bomb with code '1111'
    Then I should see 'Activated'

  Scenario: Deactivate the bomb
    Given Configure bomb with codes '2222' and '0000'
    When I activate the bomb with code '2222'
    When I fill in '0000' to deactivate the bomb
    Then I should see 'Deactivated'

  Scenario: Input incorrect activation code 3 times
    Given Configure bomb with codes '2222' and '3151'
    When I activate the bomb with code '6666'
    When I activate the bomb with code '6667'
    When I activate the bomb with code '6668'
    Then I should see the bomb as 'Exploded'

  Scenario: Input incorrect deactivation code 3 times
    Given Configure bomb with codes '2222' and '3151'
    When I activate the bomb with code '2222'
    When I fill in '1234' to deactivate the bomb
    When I fill in '5678' to deactivate the bomb
    When I fill in '8544' to deactivate the bomb
    Then I should see the bomb as 'Exploded'

  Scenario: Activate bomb with deactivation code
    Given Configure bomb with codes '4444' and '5555'
    When I activate the bomb with code '5555'
    Then I should remain on the activation page

  Scenario: Deactivate bomb with activation code
    Given Configure bomb with codes '3333' and '6666'
    When I activate the bomb with code '3333'
    When I fill in '6666' to deactivate the bomb

  Scenario: Attempting to activate a already activated bomb
    Given Configure bomb with codes '2222' and '0000'
    When I activate the bomb with code '2222'
    Then I should see 'Activated'
    Given I visit the configuration page
    Given Configure bomb with codes '2222' and '0000'
    When I activate the bomb with code '2222'
    Then I should see 'Activated'

  Scenario: When user does not enter deactivation code on activated bomb
    Given Configure bomb with codes '2222' and '0000'
    When I activate the bomb with code '2222'
    When I do nothing on the deactivation page for 30 seconds
    Then I should see the bomb as 'Exploded'

  Scenario: When a user snips the bomb wire
    Given Configure bomb with codes '2222' and '0000'
    When I activate the bomb with code '2222'
    When I snip the wire
    Then I should see 'Deactivated'

  Scenario: User inserts letters for codes on config
    Given Configure bomb with codes '2a33' and 'ABBA'
    Then The bomb should not be configured

  Scenario: User enters letters for activation code to activate bomb
    Given Configure bomb with codes '2222' and '3151'
    When I activate the bomb with code 'ABBA'
    Then I should remain on the activation page

