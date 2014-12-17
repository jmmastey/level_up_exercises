Feature: I visit the home page

Background:
  Given I go to the home page
  And the bomb should be inactive

Scenario: I enter the correct codes
  When I enter the correct codes and submit
  Then I go to the bomb page
  And the bomb should be active
Scenario: I enter the incorrect codes
  When I enter the incorrect codes and submit
  Then the bomb should be inactive
  # And warning should appear
Scenario: I enter the incorrect codes three times
  When I enter the incorrect codes three times
  Then the bomb should explode


