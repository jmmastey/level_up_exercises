Feature: Boot the bomb
  As a super villain
  I want to boot a bomb
  So that I can blow up everything

  Scenario: I visit the bomb booting page
    Given The bomb is not booted
    When I visit the bomb booting page
    Then I should see "The bomb"
    And the "activation_code" field should contain "1234"
    And the "deactivation_code" field should contain "0000"

  Scenario: I boot the bomb with default codes
    Given The bomb is not booted
    When I visit the bomb booting page
    And I press "arm-button"
    Then I should see "bomb is not activated"

  Scenario: I boot the bomb with custom codes
    Given The bomb is not booted
    When I visit the bomb booting page
    And I fill in "activation_code" with "9876"
    And I fill in "deactivation_code" with "9999"
    And I press "arm-button"
    Then I should see "bomb is not activated"
