Feature: Dropping bombs
  In order to activate and deactivate the bomb
  As a visitor to the site
  I want to set the codes

  Scenario: Bomb is not booted
    Given I visit the home page
    When I do nothing
    Then the bomb should be off

  Scenario: Bomb is booted
    Given I visit the home page
    When I boot the bomb
    Then the bomb should be booted

  Scenario: Activation code is set
    Given I visit the home page
    When I configure the activation code "2345"
    And I boot the bomb
    Then the bomb should be booted

  Scenario: Activation code is invalid
    Given I visit the home page
    When I configure the activation code "a123"
    And I boot the bomb
    Then the bomb should be off

  Scenario: Bomb is activated
    Given the bomb is booted with default config
    When I submit the activation code "1234"
    Then the bomb is now activated

  Scenario: Custom activation code
    Given I visit the home page
    When I configure the activation code "56789"
    And I boot the bomb
    And I submit the activation code "56789"
    Then the bomb is now activated

  Scenario: Bomb is deactivated
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "0000"
    Then the bomb should be deactivated

  Scenario: Wrong deactivation code
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "3333"
    Then the bomb is now activated

  Scenario: Wrong deactivation code first
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "3333"
    When I submit the deactivation code "0000"
    Then the bomb should be deactivated

  Scenario: Bomb explodes
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "3333"
    When I submit the deactivation code "1111"
    When I submit the deactivation code "2222"
    Then the bomb should explode
