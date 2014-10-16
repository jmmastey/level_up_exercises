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

  Scenario: Activate bomb with deactivation code
    Given I have a configured bomb with default codes
    When I activate the bomb with code '1234'
    Then I should remain on the activation page

  Scenario: Deactivate bomb with activation code
    Given I have a configured bomb with default codes
    When I activate the bomb with code '1111'
    When I fill in '6666' to deactivate the bomb
    Then I should remain on the deactivation page

  Scenario: User inserts letters for codes on config
    Given Configure bomb with codes '2a33' and 'ABBA'
    Then The bomb should not be configured

  Scenario: User enters letters for activation code to activate bomb
    Given I have a configured bomb with default codes
    When I activate the bomb with code 'ABBA'
    Then I should remain on the activation page

  Scenario: User creates a custom code to create a bomb
    Given Configure bomb with codes '6666' and '9999'
    When I activate the bomb with code '6666'
    Then I should see 'Activated'
      And I fill in '9999' to deactivate the bomb
    Then I should see 'Deactivated'