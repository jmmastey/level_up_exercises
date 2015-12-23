Feature: Welcome page
  In order to access the Overlord program
  As a Vault Boy
  I want to enter Megaton

  Scenario: On the welcome page
    When I am on the welcome page
    Then the index page should contain the title and welcome link

  Scenario: Enter Megaton
    Given I am on the welcome page
    When I enter Megaton
    Then I should be directed to the bomb page
