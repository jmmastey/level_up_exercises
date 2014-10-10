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
    Given I visit the activation page

  @activation_code
  Scenario: Activate the bomb
    Given Configure bomb with codes '1111' and '8888'
    Then I should see 'Activated'

  Scenario: Deactivate the bomb
    Given Configure bomb with codes '2222' and '0000'
    When I fill in '0000' to deactivate the bomb
    Then I should see 'Deactivated'

  Scenario: Input incorrect deactivation code 3 times
    Given Configure bomb with codes '2222' and '3151'
    #When I fill in '1234' to deactivate the bomb
    #When I fill in '5678' to deactivate the bomb
    When I fill in '8544' to deactivate the bomb
    Then I should see the bomb as 'Exploded'

  Scenario: Attempting to activate a already activated bomb
    Given Configure bomb with codes '2222' and '0000'
    Then I should see 'Activated'
    Given I visit the activation page
    Given Configure bomb with codes '2222' and '0000'
    Then I should see 'Activated'

  Scenario: When user does not enter deactivation code on activated bomb
    Given Configure bomb with codes '2222' and '0000'
    When I do nothing on the deactivation page for 30 seconds
    Then I should see the bomb as 'Exploded'

  Scenario: When a user snips the bomb wire
    Given Configure bomb with codes '2222' and '0000'
    When I snip the wire
    Then I should see 'Deactivated'
