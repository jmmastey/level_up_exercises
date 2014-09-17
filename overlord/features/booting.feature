Feature: Booting
  As a super-villain
  I want to boot a bomb
  so that I can use it later

  Background:
    Given my bomb is not booted

  Scenario: Booting without codes
    When I boot my bomb
    Then my bomb should be inactive
    And my bomb's activation code should be 1234
    And my bomb's deactivation code should be 0000

  Scenario: Booting with codes
    Given I set my activation code to 3490
    And I set my deactivation code to 1212
    When I boot my bomb
    Then my bomb should be inactive
    And my bomb's activation code should be 3490
    And my bomb's deactivation code should be 1212
