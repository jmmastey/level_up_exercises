Feature: Bomb Provisioning

  As a super-villain bent on dominating the world's information history
  I need an eigenstate-selecting temporal dispersion Internet bomb
  So that I can destroy online information across all probable time-lines

  As a super-villain
  I need the ability to customize bomb activation and deactivation codes
  So that I do not rely on widely known default settings

  As a super-villain
  I need the ability to customize the countdown timer value
  So that I give a deadline for ransom and/or blackmail demands

  @javascript
  Scenario: Provisioned bombs have a default state
    Given a provisioned bomb
    Then the bomb will display as inactive
    And the countdown timer will be set to "30" seconds

  @javascript
  Scenario Outline: Custom activation codes must be four numeric characters
    Given the bomb provisioning page
    When an invalid custom activation <code> is provided
    Then the provision process indicates the custom activation code is invalid

    Examples:
      | code    |
      | "12345" |
      | "aaaa"  |
      | "1ab3"  |
      | "12"    |

  @javascript
  Scenario Outline: Custom deactivation codes must be four numeric characters
    Given the bomb provisioning page
    When an invalid custom deactivation <code> is provided
    Then the provision process indicates the custom deactivation code is invalid

    Examples:
      | code    |
      | "12345" |
      | "aaaa"  |
      | "1ab3"  |
      | "12"    |

  @javascript
  Scenario Outline: Custom countdown values must be a whole number of seconds
    Given the bomb provisioning page
    When an invalid custom countdown <value> is provided
    Then the provision process indicates the custom countdown value is invalid

    Examples:
      | value |
      | "1.0" |
      | ":30" |
      | "abc" |
