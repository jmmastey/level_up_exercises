Feature: Tell the user how to dress
  In order to be comfortable
  As a user
  I want to be told how to dress based on weather

  Background:
    Given I am on the weather page

  Scenario: Dress for piping hot weather
    When the weather for the next hour is piping hot
    Then I should be told to dress for piping hot weather

  Scenario: Dress for warm weather
    When the weather for the next hour is warm
    Then I should be told to dress for warm weather

  Scenario: Dress for cool weather
    When the weather for the next hour is cool
    Then I should be told to dress for cool weather

  Scenario: Dress for cold weather
    When the weather for the next hour is cold
    Then I should be told to dress for cold weather

  Scenario: Dress for subzero weather
    When the weather for the next hour is subzero
    Then I should be told to dress for subzero weather