Ability: Timer
  As a super-villain
  I need the bomb to have a countdown timer
  So that I can avoid having the bomb detonate immediately upon activation

  @javascript
  Scenario Outline: Timer countdown must be a whole number of seconds
    Given the bomb provisioning page
    When an invalid countdown <value> is provided
    Then the display indicates the countdown value is invalid

    Examples:
      | value |
      | "1.0" |
      | ".02" |
      | "abc" |

  @javascript
  Scenario: Bombs have a default countdown timer
    Given an activated bomb
    Then the countdown timer will be close to "30" seconds

  #@javascript
  #Scenario: Custom countdown timer values can be provided
    #Given a bomb provisioned with a custom countdown timer of "9292"
