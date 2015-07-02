#encoding: utf-8
Feature: Hacking into a panel
  In order to hack into a panel
  As an evil overlord
  I should be able to toggle buttons
  And submit hacks

  Scenario: Pressing a 0 button
    Given I'm at the bomb page
    When I press a 0 button on a panel
    Then it should change its value to 1

  Scenario: Pressing a 1 button
    Given I'm at the bomb page
    When I press a 1 button on a panel
    Then it should change its value to 0

  Scenario: Submitting correct panel hack
    Given I'm at the bomb page
    And the bomb is armed
    And I choose a panel
    And the depressed buttons on the panel form a correct sequence
    When I press submit on that panel
    Then the panel should turn green

  Scenario: Submitting incorrect panel hack
    Given I'm at the bomb page
    And the bomb is armed
    And I choose a panel
    And the depressed buttons on the panel form an incorrect sequence
    When I press submit on that panel
    Then the panel buttons should reset