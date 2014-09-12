Feature: Booting
  In order to use a bomb
  As a super villian
  I want to boot a bomb

  Scenario: Boot a bomb
    When I boot a bomb
    Then the bomb should not be activated
    And its activation code should be 1234
    And its deactivation code should be 0000

  Scenario: Boot a bomb with codes
    Given my activation code is 5495
    And my deactivation code is 1250
    When I boot a bomb with both codes
    Then the bomb should not be activated
    And its activation code should be 5495
    And its deactivation code should be 1250
