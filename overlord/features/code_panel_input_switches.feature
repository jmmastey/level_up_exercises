Feature: code panel input swithces
  In order to help speed up entering code sequences
  As an overlord criminal under time pressure
  I want the code input fields to automatically skip to the next field

  Background:
    Given I am on the bomb page

  Scenario: Skips from digit-1 to digit-2
    When I input "6" for digit-1
    Then "digit-2" should be focused

  Scenario: Skips from digit-2 to digit-3
    When I input "9" for digit-2
    Then "digit-3" should be focused

  Scenario: Skips from digit-3 to digit-4
    When I input "0" for digit-3
    Then "digit-4" should be focused

  Scenario: Skips from digit-4 to submit button
    When I input "8" for digit-4
    Then "input-submit" should be focused

  Scenario: Clears digit input fields on submission
    When I submit a valid code input
    Then all code input fields are empty

  Scenario: Flashes warning when invalid code format is submitted
    When I submit an invalid code input
    Then all input fields flash a warning
