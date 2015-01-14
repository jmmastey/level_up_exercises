Feature: I change the codes

Background:
  Given I go to the home page
  And I go to the home page
  And I enter new codes into change form


Scenario: I change activation and deactivate to new codes
  When I enter new code into code activation form
  Then I am on the bomb page
  And the bomb should be active

Scenario: I change the activation code and enter original activation
  When I enter the correct codes and submit
  Then the bomb should be inactive

Scenario: I change the deactivation code and enter deactivation
  When I enter new code into code activation form
  Then I enter new code into deactivation form
  And the bomb should be inactive

Scenario: I change the deactivation code and enter original deactivation
  When I enter new code into code activation form
  And I enter original deactivation code
  Then the bomb should be active
@javascript
Scenario: I enter non numbers into the change code form
  When I enter bad codes that have letters into the change form
  Then an error should appear
  And I enter bad codes into activation form
  And the bomb should be inactive