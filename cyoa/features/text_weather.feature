Feature: Text weather updates
  In order to dress comfortably
  As a registered user
  I want to be texted weather updates

  Background:
    Given I am a registered user
    And I have setup daily text notifications for 6:00AM

  Scenario: Warm dress notification
    Given it is 6:00AM
    And the weather for the next hour is warm
    Then I receive a text
    And the text tells me to dress for warm weather
    And the text tells me the weather for the next hour is warm
