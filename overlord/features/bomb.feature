Feature: Control the bomb
  In order to make sure we can use a bomb safely
  As a super villain
  I want to activate and deactivate a bomb on command

  Scenario: Boot the bomb without activating
    Given I boot the bomb
    Then the bomb should not be activated

  Scenario: Activate the bomb
    Given I have booted the bomb
    When I enter the right activation code
    Then the bomb should activate

  Scenario: Display the activated status
    Given I have booted the bomb
    When the bomb has been activated
    Then the status indicator should show as activated

  Scenario: Deactivate the bomb
    Given the bomb has been activated
    When I enter the right deactivation code
    Then the bomb should deactivate

  Scenario: Display the deactivated status
    Given I have booted the bomb
    When the bomb has been deactivated
    Then the status indicator should show as deactivated

  Scenario: The bomb explodes
    Given the bomb has been activated
    When I enter the wrong deactivation code three times
    Then the bomb explodes
    And the buttons do not work
