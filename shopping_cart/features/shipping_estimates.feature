Feature: Get estimated shipping costs based on address

	As a shopper
	I want to receive the estimated cost of shipping for the the items in my cart
	to an adress I enter

	Scenario: Cannot receive shipping estimate with no items in cart
		Given I have no items in my cart
		And I am on the cart list page
		Then I should not be able to enter my address for shipping

	Scenario: Enter shipping address with non-empty cart
		Given I have a non-empty cart
		When I am on the cart checkout page
		Then I expect to be able to enter my shipping adress

	Scenario: Receive estimate of shipping costs for items
		Given I have multiple items in my cart
		And I'm ready to checkout
		And I am on the cart checkout page
		When I enter my shipping address
		Then I expect to see estimated cost of shipping items to specified address

	Scenario Outline: Receive estimate of shipping costs for items
		Given I have multiple items in my cart
		And a subtotal of $10
		And I am on the cart checkout page
        When I enter "<address>", "<address2>", "<city>", "<state>" and "<zipcode>"
        And I click "Estimate shipping" button
        Then I should see "<message>"
        And the shipping cost has value "<shipping_cost>"
        And the total cost is "<total_cost>"

    @happy
    Examples:
        | address        | address2 |city           | state  | zipcode   | shipping_cost   | total_cost  | message |
        | 1 E Madison St | Apt 915  |Chicago        | IL     | 60606     | 2               | 12          |         |
        | 11  Wall St    |          |New York City  | NY     | W11 2BQ   | 10              | 20          |         | 
	@sad
    Examples:
        | address        | address2 |city           | state  | zipcode   | shipping_cost   | total_cost  | message |
        | 1 E Madison St | Apt 915  |Chicago        | QS     | 60606     | 0               | 10          | "Invalid Address" |
        | 1 E Madison St |          |sdadsfg        | IL     | 60606     | 0               | 10          | "Invalid Address" |
        | 1 E ertcgdf St |          |Chicago        | IL     | 60606     | 0               | 10          | "Invalid Address" |
        | 1 E ertcgdf St |          |Chicago        | IL     | 99999     | 0               | 10          | "Invalid Address" |
        | 11  Wall St    | Suite 5D |London         | England| 00000     | 0               | 10          | "We only ship to the continental United States" | 
	@bad
    Examples:
        | address        | address2 |city           | state  | zipcode   | shipping_cost   | total_cost  | message |
        |                | Apt 915  |Chicago        | IL     | 60606     | 0               | 10         | "Please enter all information" |
        | 1 E ertcgdf St | Apt 915  |               | IL     | 60606     | 0               | 10         | "Please enter all information" |
        | 1 E ertcgdf St | Apt 915  |Chicago        |        | 60606     | 0               | 10         | "Please enter all information" |
        | 1 E ertcgdf St | Apt 915  |Chicago        | IL     | 345       | 0               | 10         | "Please enter all information" |
        | 1 E ertcgdf St | Apt 915  |Chicago        | IL     |           | 0               | 10         | "Please enter all information" |
