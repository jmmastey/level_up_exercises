Feature: Dropping bombs
  As a visitor to the site
  I want to boot and activate the bomb
  Because I need to be a supervillain

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

  Scenario: Activation code is empty
    Given I visit the home page
    When I configure the activation code ""
    And I boot the bomb
    Then the bomb should be off
    And I see an configuration error message

  Scenario: Activation code is invalid
    Given I visit the home page
    When I configure the activation code "a123"
    And I boot the bomb
    Then the bomb should be off
    And I see an configuration error message

  Scenario: Deactivation code is invalid
    Given I visit the home page
    When I configure the deactivation code "a123"
    And I boot the bomb
    Then the bomb should be off
    And I see an configuration error message

  Scenario: Bomb is activated
    Given the bomb is booted with default config
    When I submit the activation code "1234"
    Then the bomb is now activated

  Scenario: Activation code is wrong
    Given the bomb is booted with default config
    When I submit the activation code "2345"
    Then I see an activation error message

  Scenario: Custom activation code
    Given I visit the home page
    When I configure the activation code "56789"
    And I boot the bomb
    And I submit the activation code "56789"
    Then the bomb is now activated
