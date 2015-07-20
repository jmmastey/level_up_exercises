Feature: Dropping bombs
  In order to activate and deactivate the bomb
  As a visitor to the site
  I want to set the codes

  Scenario: Bomb is booted
    Given I am a website visitor
    When I boot the bomb
    Then the bomb should be booted
    And the bomb should not be activated
    And the activation code is set to 1234
    And the deactivation code is set to 0000

  Scenario: Activation code is set
    Given I am a website visitor
    When I type in the activation code 1234
    When I boot the bomb
    Then the bomb should be booted
    And the bomb should not be activated
    And the activation code is set to 1234
    And the deactivation code is set to 0000

  Scenario: Activation code is invalid
    Given I am a website visitor
    When I type in the activation code a123
    And I boot the bomb
    Then the bomb should not be booted

  Scenario: Activation code is invalid
    Given I am a website visitor
    When I boot the bomb
    And I type in the activation code a123
    Then the bomb should not be activated

  Scenario: Custom activation code
    Given the bomb is activated with code 56789
    When I boot the bomb
    And I type in the activation code 56789
    Then the bomb is activated
    And the bomb is active

  Scenario: Repeating the activation code
    Given the bomb is activated
    When I type in the activation code 5678
    Then the bomb is activated

  Scenario: Bomb is deactivated
    Given the bomb is activated
    When I type in the deactivation code 1234
    Then the bomb should be deactivated
    And the bomb is inactive

  Scenario: Wrong deactivation code
    Given the bomb is activated
    When I type in the deactivation code 3333
    Then the bomb should not be deactivated
    And the bomb is active

  Scenario: Wrong deactivation code first
    Given the bomb is activated
    When I type in the deactivation code 3333
    When I type in the deactivation code 0000
    Then the bomb should be deactivated
    And the bomb is inactive

  Scenario: Bomb explodes
    Given the bomb is activated
    When I type in the deactivation code 3333
    When I type in the deactivation code 1111
    When I type in the deactivation code 2222
    Then the bomb should explode
    And the bomb is inactive

  Scenario: Bomb explodes
    Given the bomb explodes
    When I type in the activation code 3333
    Then the bomb is inactive
