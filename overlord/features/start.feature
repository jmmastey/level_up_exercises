Feature: I visit the home page

Background:
  Given I go to the home page
  Given the bomb should be inactive

Scenario: I enter the correct codes
  When I enter the correct codes and submit
  Then I go to the bomb page
  Then the bomb should be active
@javascript
Scenario: I enter the incorrect codes
  When I enter the incorrect codes and submit
  Then the bomb should be inactive
  Then warning should appear
Scenario: I enter the incorrect codes three times
  When


