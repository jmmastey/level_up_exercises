Feature: Booting the Bomb
  As a User
  I want to boot the bomb
  In order to activate or deactivate it

  Background:
    Given I am on the home page

  Scenario: Visiting the home page
    Then I should see a set activation code entry box
    And I should see a set de-activation code entry box
    And I should see a boot button

  Scenario: Set activation and deactivation codes and boot the bomb
    When I set the activation and deactivation codes
    Then the bomb should be deactivated

  Scenario: Do not set activation and deactivation codes and boot the bomb
    When I click the Boot Bomb button
    Then I should be on the bomb interface
    And the bomb should be deactivated
