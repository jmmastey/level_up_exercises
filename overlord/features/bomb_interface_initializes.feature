Feature: Bomb interface loads on webserver
  As a super-villian
  I want to start the bomb interface
  So that I can activate or deactivate the bomb

  Scenario: Visit home page
    Givem I am on the bomb's home page
    Then I should see the status of the bomb
    And I should be able to boot the bomb
    And I should see fields to enter the activation or deactivation codes for the bomb
