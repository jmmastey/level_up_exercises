Feature: Activating the Bomb
  In order to take over the world
  As a super villian
  I want to be able to activate my bomb once booted

  Scenario: Activating with correct code activates
    Given I have booted the bomb with default codes
    When I activate it with 1234
    Then I should see a status of "activated"
    And there should be a/an "code" field

  Scenario: Activating with correct custom code activates
    Given I have booted the bomb with custom codes 1111 2222
    When I activate it with 1111
    Then I should see a status of "activated"

  Scenario: Activating with incorrect code stays deactivated
    Given I have booted the bomb with default codes
    When I activate it with 0000
    Then I should see a status of "deactivated"
