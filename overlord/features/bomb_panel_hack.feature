#encoding: utf-8

@panel
Feature: Hacking into a panel
  In order to hack into a panel
  As an evil overlord
  I should be able to toggle buttons
  And submit hacks

  @happy
  Scenario: Pressing a 0 button
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is armed
    When I press a 0 button on a panel
    Then it should change its value to 1

  @happy
  Scenario: Pressing a 1 button
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is armed
    When I press a 1 button on a panel
    Then it should change its value to 0

  @happy
  Scenario: Submitting correct panel hack
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is armed
    And I choose a panel
    And the depressed buttons form a correct sequence
    When I press submit on that panel
    Then the panel should turn green

  @happy
  Scenario: Submitting incorrect panel hack
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is armed
    And I choose a panel
    And the depressed buttons form an incorrect sequence
    When I press submit on that panel
    Then the panel buttons should reset

  @happy
  Scenario: Hacking all panels
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is armed
    And I enter correct sequences for all panels
    Then the timer should stop
    And I should be unable to arm the bomb
    And I should be unable to disarm the bomb
    And the bomb should be hacked