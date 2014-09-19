Feature: Booting
  As a super-villain
  I want to boot a bomb
  so that I can use it later

  Background:
    Given my bomb is not booted

  Scenario: Booting without codes
    When I boot my bomb
    Then my bomb should be inactive

  Scenario: Booting with codes
    Given I set my activation code to 3490
    And I set my deactivation code to 1212
    When I boot my bomb
    Then my bomb should be inactive
