Feature: Boot
  As a villain
  I want to be able to boot the bomb
  In order to begin extorting society

  Scenario: Bomb offline until booted
    When I login as a villain
    Then I should see the status of the bomb is offline

  Scenario: Only one bomb can be booted at a time
    Given I am logged in as a villain
    And the bomb has been booted
    When I boot the bomb
    Then I should see a notification that the bomb has already been booted

  Scenario: Cannot boot bomb with non-numeric activation code
    Given I am logged in as a villain
    When I boot with an invalid activation code
    And I boot the bomb
    Then I should see a notification with the rules for valid activation codes

  @User_Roles
  Scenario: Freshly booted bomb is inactive for villain
    Given I am logged in as a villain
    When I boot the bomb
    Then I should see the status of the bomb is inactive

  Scenario: Only villians can boot the bomb: generic
    Given I am logged in as a citizen
    When I boot the bomb
    Then I should see the status of the bomb is offline

  Scenario: Only villians can boot the bomb: dev
    Given I am logged in as a dev
    When I boot the bomb
    Then I should see the status of the bomb is offline
