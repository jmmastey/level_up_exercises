Feature: Bomb boots with activation and deactivation codes set
  As a super-villian
  I want to boot the bomb
  So that I can activate or deactivate the bomb

  Scenario: Visit home page
    When I am on the home page
    Then I should see fields to enter the activation and deactivation codes for the bomb
    And I should see a button to boot the bomb

  Scenario: Use default activation/deactivation codes
    When I do not enter an activation code or deactivation code
    Then the bomb should boot
    And the bomb should not be activated yet

  Scenario: Enter custom activation/deactivation codes
    When I enter "1111" for the activation code
    And I enter "2222" for the deactivation code
    Then the bomb should boot
    And the bomb should not be activated yet