Feature: Activation code
  In order to maintain personal control over the activation of the bomb
  As a super villain
  I want my bomb to be activated by entering a 4-digit code

Scenario Outline: Activate the bomb or not
    Given an inactive bomb with activation code "<correct>"
    When I activate the bomb with "<provided>"
    Then the bomb is <status>

    Examples:
      | correct | provided | status   |
      | 1234    | 1234     | active   |
      | 1234    | 1111     | inactive |
      | 1234    | 12345    | inactive |
      | 1234    | 123      | inactive |
      | 1234    | abcd     | inactive |
      | 1234    |          | inactive |

  Scenario Outline: Entering the activation code extra times has no effect
    Given an active bomb with activation code "1234"
    When some incompetent minion activates the bomb with "1234" <count> times
    Then the bomb is active

    Examples:
      | count |
      | 1     |
      | 2     |
      | 3     |
      | 10    |

  Scenario: Activating with the wrong code provides a message
    Given an inactive bomb with activation code "1234"
    When some incompetent minion activates the bomb with "0000"
    Then he should see "You lose.  Thanks for playing, please try again."
    
  