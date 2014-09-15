Feature: Booting
  As a super-villain
  I want to boot a bomb
  so that I can use it later

  Scenario: Booting without codes
    Given my bomb is not booted
    When I boot my bomb
    Then my bomb should be inactive
    And my bomb's activation code should be 1234
    And my bomb's deactivation code should be 0000

  Scenario: Booting with codes
    Given my bomb is not booted
    And I set my activation code to 3490
    And I set my deactivation code to 1212
    When I boot my bomb
    Then my bomb should be inactive
    And my bomb's activation code should be 3490
    And my bomb's deactivation code should be 1212

  Scenario: Booting with bad codes
    Given my bomb is not booted
    When I set my activation code to "Dog"
    And I boot my bomb
    Then my bomb should reject the code
