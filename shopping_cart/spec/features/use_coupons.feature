Feature: Use Coupons
  In order to save money
  As a customer
  I want to use a coupon on my order

  Scenario Outline: Try to enter coupon codes
    Given I am <logged_in>
    And I am on the order total page
    And my total is <subtotal>
    And coupon code <coupon_code> is <valid>
    And the coupon has a value of <coupon_value>
    When I enter coupon code <enter_coupon_code>
    Then I see <message>
    And my total is <total>

  @happy
  Examples: Successfully applied coupons
    | logged_in     | subtotal | coupon_code | valid   | coupon_value | enter_coupon_code | message                                              | total |
    | logged in     | 10.00    | 1234        | valid   | 5.00         | 1234              | a coupon successfully applied message                | 5.00  |
    | logged in     | 20.00    | 1111        | valid   | 20.00        | 1111              | a coupon successfully applied message                | 0.00  |
    | logged in     | 20.00    | 1111        | valid   | 30.00        | 1111              | a coupon successfully applied with remainder message | 0.00  |
    
  @sad
  Examples: Unsuccessfully applied coupons
    | logged_in     | subtotal | coupon_code | valid   | coupon_value | enter_coupon_code | message                                              | total |
    | not logged in | 10.00    | 1234        | valid   | 5.00         | 1234              | a message that only registered users can use coupons | 10.00 |
    | logged in     | 20.00    | 1111        | invalid | 0.00         | 1111              | a coupon does not exist message                      | 20.00 |
    | logged in     | 10.00    | 1234        | valid   | 0.00         | 1234              | a coupon balance is exhaused message                 | 10.00 |