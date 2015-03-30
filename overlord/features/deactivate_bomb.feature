Feature: bomb deactivation
  In order to deactivate the bomb
  As a CT
  I want to be able to input the deactivation key and deactivate the bomb

  Background:
    Given there is a bomb
    And it has been activated

  Scenario: attempting to deactivate with an incorrect deactivation code
    When I enter an incorrect deactivation code in the code field
    And I click on the deactivate button
    Then I should be redirected to a page with an active bomb

  Scenario: attempting to deactivate with a correct deactivation code
    When I enter the correct deactivation code in the code field
    And I click on the deactivate button
    Then I should be redirected to a page with an inactive bomb

  Scenario: attempting to detonate the bomb
    When I deactivate the bomb incorrectly three times
    Then I should be redirected to a page with a detonated bomb
