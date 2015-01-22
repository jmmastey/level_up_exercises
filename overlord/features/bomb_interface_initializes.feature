Feature: Bomb interface loads on webserver
  As a super-villian
  I want to start the bomb interface
  So that I can activate or deactivate the bomb

  Scenario: Visit home page
    Given I am on the home page
    THen the bomb should boot
    And I should see the status of the bomb
    And I should see fields to enter the activation and deactivation codes for the bomb
