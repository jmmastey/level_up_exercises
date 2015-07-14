Feature:
  As a user either logged in or anonmyous
  Entering a coupon should either apply the coupon and update the totals
  or alert me that the coupon was invalid

  Note: Each item is $100 for testing
        And value is a % off original price
          100 = 100%
          75 = 75%
          60 = 60%

  Background:
    Given there is 2 "WiiU" and 1 "PS4" and 3 "SNES" in the cart
    And the user is on the cart page
    And the total cost is 600

  Scenario: Check coupon process
    When the user enters a <state> <value> <product> coupon
    Then the total cost is <result>
    And the user sees the message "<message>"
  Examples:
    | state   | value | product | message        | result |
    | expired | 50    | WiiU    | Coupon Expired | 600    |
    | expired | 50    | all     | Coupon Expired | 600    |
    | valid   | 50    | WiiU    | Coupon Applied | 500    |
    | valid   | 25    | PS4     | Coupon Applied | 575    |
    | valid   | 75    | SNES    | Coupon Applied | 375    |
    | valid   | 10    | all     | Coupon Applied | 540    |
    | valid   | 90    | all     | Coupon Applied | 60     |
