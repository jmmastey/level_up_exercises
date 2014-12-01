Feature: Use coupons
  As a shopper
  In order to get the best deal available
  I want to use coupons

  Background:
    Given the availability of the following coupon
      | name         | discount     | status  | condition             |
      | EXPIRED      |              | expired |                       |
      | 10OFF        | $10          | active  | Minimum $100 purchase |
      | USERBOB      | 25%          | active  | User must be bob      |
      | 5OFF         | $5           | active  | none                  |

  @happy
  Scenario: Use general coupons
    Given I am not logged in
      And I have a cart filled with $20 worth of goods
    When I use "5OFF" coupon
    Then my new cart total should be $15

  @happy
  Scenario Outline: Uses coupon with conditions
    Given I am logged in as 'Bob'
      And I have cart filled with $150 of worth of goods
    When I use "<coupon>" coupon
    Then my new cart total should be <total>

    Examples:
      | coupon  | total   |
      | 10OFF   | $140    |
      | USERBOB | $112.50 |
      | 5OFF    | $145    |

  @happy
  Scenario: Uses multiple coupons
    Given I am logged in as 'Bob'
      And I have cart filled with $150 worth of goods
    When I use "10OFF" coupon
      And I use "USERBOB" coupon
    Then my new cart total should be $105

  @sad
  Scenario Outline: Uses coupons without matching conditions
    Given I am logged in as 'Jones'
      And I have cart filled with $90 worth of goods
    When I use <coupon> coupon
    Then my new cart total should be $90
      And I should see <message>

    Examples:
      | coupon  | message                                |
      | 10OFF   | did not match minimum purchase         |
      | USERBOB | you are not allowed to use this coupon |
