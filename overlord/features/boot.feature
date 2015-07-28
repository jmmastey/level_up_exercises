Feature: Dropping bombs
  As a supervillain
  I want to boot and activate the bomb
  Because I need to be a supervillain

  Scenario: Bomb is not booted
    When I visit "/"
    Then the bomb is "Off!"

  Scenario: Bomb is booted
    Given I visit "/"
    When I boot the bomb
    Then the bomb is "Booted up!"

  Scenario: Activation code is set
    Given I visit "/"
    When I configure the activation code "2345"
    And I boot the bomb
    Then the bomb is "Booted up!"

  Scenario: Activation code is empty
    Given I visit "/"
    When I configure the activation code ""
    And I boot the bomb
    Then the bomb is "Off!"
    And I see "Invalid activation code"

  Scenario: Activation code is invalid
    Given I visit "/"
    When I configure the activation code "a123"
    And I boot the bomb
    Then the bomb is "Off!"
    And I see "Invalid activation code"

  Scenario: Deactivation code is invalid
    Given I visit "/"
    When I configure the deactivation code "a123"
    And I boot the bomb
    Then the bomb is "Off!"
    And I see "Invalid deactivation code"

  Scenario: Both codes are invalid
    Given I visit "/"
    When I configure the activation code "234b"
    And I configure the deactivation code "a123"
    And I boot the bomb
    Then the bomb is "Off!"
    And I see "Invalid activation code"
    And I see "Invalid deactivation code"

  Scenario: Bomb is activated
    Given the bomb is booted with default config
    When I submit the activation code "1234"
    Then the bomb is "Activated!"

  Scenario: Activation code is wrong
    Given the bomb is booted with default config
    When I submit the activation code "2345"
    Then I see "Wrong activation code"

  Scenario: Custom activation code
    Given I visit "/"
    When I configure the activation code "56789"
    And I boot the bomb
    And I submit the activation code "56789"
    Then the bomb is "Activated!"
