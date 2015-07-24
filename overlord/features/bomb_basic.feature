#encoding: utf-8

@bad-codes
Feature: Basic Bomb
  In order to do anything to the bomb
  As an eveil overlord
  I should see correct behavior

  @happy
  Scenario: Launching the bomb page
    Given I'm at the bomb page
    Then the bomb should be disarmed