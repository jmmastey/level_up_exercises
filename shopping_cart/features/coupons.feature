Feature: Apply coupon/promotion
	As a shopper
	I want to be able to claim coupons and promotions on items I have in my cart
	So that I can save money on the items I want to purchase

	Scenario: Cannot enter promotion when cart is empty
		Given a cart with no items
		When I am on the cart checkout page
		Then I should not be able to enter a promotion/coupon code

	Scenario: Entering a coupon/promotion code
		Given a non-empty cart
		When I am on the cart checkout page
		Then I should be able to enter a code for a coupon or promotion

	Scenario: Applying a valid coupon/promotion code
		Given a non-empty cart
		When I am on the cart checkout page
		And I enter a valid code for a coupon or promotion
		Then I should see the relevant discout applied to my subtotal

	Scenario: Applying an invalid coupon/promotion code
		Given a non-empty cart
		When I am on the cart checkout page
		And I enter an invalid code for a coupon or promotion
		Then I should see a warning that code is invalid

	Scenario: Applying an expired coupon/promotion code
		Given a non-empty cart
		When I am on the cart checkout page
		And I enter an expired code for a coupon or promotion
		Then I should see a warning that code is expired

#============================================================================
# Version2
#============================================================================

Feature: Apply coupon/promotion
	As a shopper
	I want to be able to claim coupons and promotions on items I have in my cart
	So that I can save money on the items I want to purchase
    
    Background:
    	Given I have a cart with "item_1" at priced at "price_1"
		And I add "item_2" at priced at "price_2"
		And I have a subotal of "(price_1 + price_2)" # Can u do arithmetic here?

    Scenario Outline:
        When I apply coupon #"<coupon_code>" for "<amount>" off
        Then I should see the "<message>"
        And the subtotal should be "<subtotal>"

    @happy
    Examples:
        | coupon_code     | amount  | subtotal                  | message |
        | thisiscoupon1   | 5       | (price_1 + price_2) - 5   |         |
        | thisiscoupon2   | 10      | (price_1 + price_2) - 10  |         |
        | thisiscoupon3   | 15      | (price_1 + price_2) - 15  |         |

    @bad
    Examples:
        | coupon_code   | amount    | subtotal            | message                                                  |
        | notrealcoupon |           | (price_1 + price_2) | Invalid coupon code |
        | expiredCoupon |           | (price_1 + price_2) | Expired coupon      |
        |               |           | (price_1 + price_2) | Invalid coupon code |