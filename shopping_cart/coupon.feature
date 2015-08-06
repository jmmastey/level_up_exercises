Feature: Coupons
  As a user
  I want to submit a potential coupon
  In order to see if I can change the order price

  Note: Savings is a % off original price
      100 = 100%
      75 = 75%
      60 = 60%

  Background:
    Given there is 2 "WiiU" in the cart that cost 100 each
    And there is 1 "PS4" in the cart that cost 100 each
    And there is 3 "SNES" in the cart that cost 100 each
    And the user is on the cart page
    And the total cost is 600

  Scenario Outline: Check coupon process
    When the user enters a <state> <savings> <product> coupon
    Then the total cost is <result>
    And the user sees the message "<message>"
  Examples:
    | state   | savings | product | message        | result |
    | expired | 50      | WiiU    | Coupon Expired | 600    |
    | expired | 50      | all     | Coupon Expired | 600    |
    | valid   | 50      | WiiU    | Coupon Applied | 500    |
    | valid   | 25      | PS4     | Coupon Applied | 575    |
    | valid   | 75      | SNES    | Coupon Applied | 375    |
    | valid   | 10      | all     | Coupon Applied | 540    |
    | valid   | 90      | all     | Coupon Applied | 60     |
    | valid   | 110     | all     | Invalid Coupon | 600    |
    | valid   | .01     | all     | Invalid Coupon | 600    |
