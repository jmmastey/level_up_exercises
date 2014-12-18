Feature: Apply to coupon to shopping cart

Background:
        Given I have 2 "Paint Brush" in shopping cart and they cost $4
        And I have an "Oil Colors" in shopping cart and it cost $10
        And the total for these items are $14

Scenario Outline:
  Given I have <qty> "<product>" to shopping cart 
  When I applied "<coupon_code>"
  AND I press "Apply coupon"
  Then I should see the "<message>"
  And I should see a discount amount $"<discount>"
  And should see a subtotal of $"<sub_total>"
   
@happy
  Examples:
    | product      | qty | coupon_code  | discount | sub_total | message                       |
    | oil colors   | 1   | 1OFF         | 1.00     | 9.00      | The coupon code has applied  |
    | Paint Brush  | 2   | BUY1GET1FREE | 2.00     | 2.00      | The coupon code has applied |
    
@sad
  Examples:
    | product      | qty | coupon_code  | discount | sub_total | message                               |
    | oil colors   | 1   | 1OFFOn2Pair  | 0.00     | 10.00     | Minimum of 2 items need to use coupon |
    | Paint Brush  | 2   | BUY1GET1FREE | 0.00     | 4.00      | This is code only valid for Bristle   |
 
@bad
  Examples:
    | product      | qty | coupon_code  | discount | sub_total | message                                  |
    | oil colors   | 1   | abcd         | 0.00     | 10.00     | Invalid coupon code                      |
    | Paint Brush  | 2   | 10OFFHOLIDAY | 0.00     | 4.00      | Invalid coupon code. You need minimum 50$ |

@bad
  Scenario: Expired coupon
    When I add 1 of "paint brush" to shopping cart
    And I fill in "Coupon" with "SUMMERPAINT"
    And I press "Apply Coupon"
    Then I should see "This is expired coupon."
