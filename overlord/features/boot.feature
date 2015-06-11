Feature: Boot
  As a villain
  I want to be able to boot the bomb
  In order to begin extorting society

  Scenario: Bomb offline until booted
    When I login as "villain"
    Then I should see the status of the bomb is "Offline"

  Scenario: Freshly booted bomb is inactive
    Given I login as "villain"
    When I boot the bomb
    Then I should see the status of the bomb is "Inactive"

  Scenario: Only villians can boot the bomb: generic
    Given I login as "generic"
    When I boot the bomb
    Then I should see the status of the bomb is "Offline"

  Scenario: Only villians can boot the bomb: dev
    Given I login as "dev"
    When I boot the bomb
    Then I should see the status of the bomb is "Offline"

  Scenario: Only one bomb can be booted at a time
    Given I login as "villain"
    And I boot the bomb
    When I boot the bomb
    Then I should see "The bomb has already been booted"

  Scenario: Cannot boot bomb with non-numeric activation code
    Given I login as "villain"
    And I enter activation code "G4m3s"
    When I boot the bomb
    Then I should see "Activation codes must be numeric"

  Scenario: Cannot boot exploded bomb
    Given the bomb has exploded
    And I login as "villain"
    When I boot the bomb
    Then I should see "Dead men can't boot bombs"