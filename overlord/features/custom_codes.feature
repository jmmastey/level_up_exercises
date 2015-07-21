Ability: Allow Custom Bomb Codes

  As a super-villain
  I need the ability to customize bomb activation and deactivation codes
  So that I do not rely on widely known default settings

  @javascript
  Scenario: Custom activation codes can be provided
    Given a bomb provisioned with a custom activation code of "9292"
    When the custom activation code "9292" is entered
    Then the bomb will display as active

  @javascript
  Scenario: Custom deactivation codes can be provided
    Given a bomb provisioned with a custom deactivation code of "1138"
    When the custom deactivation code "1138" is entered
    Then the bomb will display as inactive

  @javascript
  Scenario Outline: Custom activation codes must be four numeric characters
    Given the bomb provisioning page
    When an invalid activation <code> is provided
    Then the display indicates the activation code is invalid

    Examples:
      | code    |
      | "12345" |
      | "aaaa"  |
      | "1ab3"  |
      | "12"    |

  @javascript
  Scenario Outline: Custom deactivation codes must be four numeric characters
    Given the bomb provisioning page
    When an invalid deactivation <code> is provided
    Then the display indicates the deactivation code is invalid

    Examples:
      | code    |
      | "12345" |
      | "aaaa"  |
      | "1ab3"  |
      | "12"    |
