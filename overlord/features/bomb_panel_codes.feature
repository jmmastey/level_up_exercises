#encoding: utf-8
Feature: Bomb Code Verification and Generation
  In order to verify that the bomb generates correct panel codes
  As an evil overlord
  I should be able to generate valid panel codes
  And entering the codes should result in successful hacks
  
  Scenario: Valid panel codes
    Given an armed bomb
    When it generates panel codes
    Then they should be less than 64
    And greater than 0

  Scenario: Example panel hacking step
    Given an armed bomb
    And a panel on that bomb
    And the code for that panel
    When I enter the correct sequence
    Then it should hack the panel

  Scenario: Example panel mis-hack step
    Given an armed bomb
    And a panel on that bomb
    And the code for that panel
    When I enter the incorrect sequence
    Then it should not hack the panel