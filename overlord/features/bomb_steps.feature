Feature: Bomb
  In order to take over the world
  As a super villian
  I want a bomb I can boot then activate/deactivate it with the correct codes

  Scenario: Booting bomb w/ deafault codes
    Given I leave activation/deactivation code fields blank
    When I press boot
    Then I should see a bomb status of deactivated
    And there should be a field to activate the bomb

  Scenario: Booting bomb w/ custom codes
    Given I enter custom activation/deactivation codes
    When I press boot
    Then I should see a status of deactivated
    And there should be a field to activate the bomb

  Scenario: Activating with correct code activates
    Given I have booted a bomb with default codes
    When I activate it with 1234
    Then I should see a status of activated

  Scenario: Activating with incorrect code stays deactivated
    Given I have booted a bomb with default codes
    When I activate it with 0000
    Then I should see a status of deactivated

  Scenario: Deactivating with correct code deactivates
    Given I have booted a bomb with default codes
    When I activate it with 1234
    And I deactivate it with 0000
    Then I should see a status of deactivated

  Scenario: Deactivating with incorrect code stays activated
    Given I have booted a bomb with default codes
    When I activate it with 1234
    And I deactivate it with 1234
    Then I should see a status of activated

  Scenario: Deactivating with incorrect code stays activated
    Given I have booted a bomb with default codes
    When I activate it with 1234
    And I deactivate it with 1234
    And I deactivate it with 1234
    And I deactivate it with 1234
    Then I should see a status of exploded

