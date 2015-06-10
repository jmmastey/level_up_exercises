Feature: Boot
  As a villain
  I want to be able to boot the bomb
  In order to start extorting society

  Scenario: Offline Bomb until booted
    Given I am logged in as "villain"
    When the bomb has not been booted
    Then I should see "Offline"

  Scenario: Freshly booted bomb is inactive
    Given I am logged in as villian
    When I click the "boot" button
    Then I should see "Inactive"

  Scenario: Only villians can boot the bomb
    Given I am logged in as "generic"
    Then I should not see the "boot" button
