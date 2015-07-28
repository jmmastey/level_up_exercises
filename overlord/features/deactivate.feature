Feature: Deactivating bombs
  As a visitor to the site
  I want to deactivate the bomb
  Because I need to save the world

  Scenario: Deactivating with default config
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "0000"
    Then the bomb is "Deactivated!"

  Scenario: Invalid deactivation code
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "333z"
    Then I see "Wrong deactivation code"
    And there are 2 attempts left

  Scenario: Wrong deactivation code
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "3333"
    Then I see "Wrong deactivation code"

  Scenario: Wrong deactivation code first
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "3333"
    And I submit the deactivation code "0000"
    Then the bomb is "Deactivated!"

  Scenario: 2 failed attempts
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "3333"
    When I submit the deactivation code "2222"
    Then there are 1 attempts left

  Scenario: Bomb explodes
    Given the bomb is booted with default config
    And the bomb is activated with default config
    When I submit the deactivation code "3333"
    When I submit the deactivation code "1111"
    When I submit the deactivation code "2222"
    Then the bomb is "Exploded!"
