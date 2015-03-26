Feature: bomb activation
  In order to activate the bomb
  As an evil overlord
  I want to be able to input the activation key and activate the bomb

  Background:
    Given there is a bomb

  Scenario: attempting to activate with an invalid code
    When I enter an incorrect activation code in the code field
    And I click on the activate button
    Then I should be redirected to a page with an inactive bomb

  Scenario: attempting to activate with a valid code
    When I enter the correct activation code in the code field
    And I click on the activate button
    Then I should be redirected to a page with an active bomb

  Scenario: attempting to activate with a valid code when already active
    When I enter the correct activation code in the code field
    And I click on the activate button
    Then I should be redirected to a page with an active bomb
