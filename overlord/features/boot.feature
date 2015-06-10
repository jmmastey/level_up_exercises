Feature: Boot
  As a villain
  I want to be able to boot the bomb
  In order to begin extorting society

  Scenario: Bomb offline until booted
    When I login as "villain"
    Then I should see the status of the bomb is "Offline"

  Scenario: Freshly booted bomb is inactive
    Given I am logged in as "villian"
    When I click the "boot" button
    Then I should see the status of the bomb is "Inactive"

  Scenario: Only villians can boot the bomb: generic
    Given I am logged in as "generic"
    When I visit the "bomb" page
    Then I should not see the "boot" button

  Scenario: Only villians can boot the bomb: dev
    Given I am logged in as "dev"
    When I visit the "bomb" page
    Then I should not see the "boot" button

  Scenario: Only one bomb can be booted at a time
    Given I am logged in as "villain"
    And the bomb has been booted
    When I click the "boot" button 
    Then nothing should happen

  Scenario: Cannot boot bomb with non-numeric activation code
    Given I am logged in as "villain"
    And I boot the bomb with an activation code of "G4m3s"
    When I click the "boot" button 
    Then I should see "Activation codes must be numeric"
