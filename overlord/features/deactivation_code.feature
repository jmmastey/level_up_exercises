Feature: Deactivation code
  As a super villain
  I want my bomb to be deactivated by entering a 4-digit code
  In order to use my bomb next time if my current plan is foiled (Curses!)

Scenario Outline: Deactivate the bomb or not
    Given an active bomb with deactivation code "<correct>"
    When I submit code "<provided>"
    Then the bomb is <status>

    Examples:
      | correct | provided | status   |
      | 0000    | 0000     | inactive |
      | 0000    | 2222     | active   |
      | 0000    | 00000    | active   |
      | 0000    | 000      | active   |
      | 0000    | abcd     | active   |
      | 0000    |          | active   |

  @javascript
  Scenario: Trying wrong deactivation codes 3 times makes the bomb explode
    Given an active bomb with deactivation code "0000"
    When some meddling fool submits 3 bad codes
    Then the bomb is exploded

  Scenario: Deactivating with the wrong code provides a message
    Given an active bomb with deactivation code "0000"
    When some meddling fool submits code "6875"
    Then the bomb is active
