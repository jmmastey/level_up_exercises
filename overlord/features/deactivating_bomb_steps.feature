Feature: Activating the Bomb
  In order to take over the world
  As a super villian
  I want to be able to deactivate my bomb once booted

  Scenario: Deactivating with correct code deactivates
    Given I have booted a bomb with default codes
    When I activate it with 1234
    And I deactivate it with 0000
    Then I should see a status of "deactivated"

  Scenario: Deactivating with correct custom code deactivates
    Given I have booted a bomb with custom codes 1111 2222
    When I activate it with 1111
    And I deactivate it with 2222
    Then I should see a status of "deactivated"

  Scenario: Deactivating with incorrect code stays activated
    Given I have booted a bomb with default codes
    When I activate it with 1234
    And I deactivate it with 1234
    Then I should see a status of "activated"

  Scenario: Deactivating with incorrect code stays activated
    Given I have booted a bomb with default codes
    When I activate it with 1234
    And I deactivate it with 1234
    And I deactivate it with 1234
    And I deactivate it with 1234
    Then I should see a status of "exploded"