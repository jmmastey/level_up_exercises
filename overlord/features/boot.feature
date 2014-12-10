Feature: I visit the home page

  Background: 
    Given I go to the home page

  Scenario: I boot the bomb with default codes
    When I try to boot the bomb with the default codes
    Then I should see the bomb is "not activated"

  Scenario: I boot the bomb with valid custom codes
    When I try to boot the bomb using "1111" and "2222"
    Then I should see the bomb is "not activated"

  Scenario Outline: I boot the bomb with invalid custom code
    When I try to boot the bomb using "<activation_code>" and "<deactivation_code>"
    Then I should see alert message "Both activation and deactivation code are numeric only"

  @sad
  Examples:
    | activation_code | deactivation_code |
    | aaaa            | 1234              |
    | 1234            | aaaa              |
    | 123a            | 1234              |
    | 1234            | 123b              |
