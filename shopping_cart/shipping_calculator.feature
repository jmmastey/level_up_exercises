Feature: weight-agnostic shipping calculator
	As a user
	I want to know the cost to ship products to my address
	So I can expect how much my grand order total will be

	Scenarios: Enter valid address to calculate shipping cost
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "175 W Jackson Blvd"
		And I fill in the shipping city field with "Chicago"
		And I fill in the shipping zipcode field with "60604"
		And I fill in the shipping state field with "IL"
		And I select "IL" from the state dropdown menu
		When I click the "Estimate shipping" button
		Then I should see "Your Shipping Estimate: $9.99"

	Scenario: User enters a nonexistent shipping address
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "1178729 W Grackackson Blvd"
		And I fill in the shipping city field with "Chicago"
		And I fill in the shipping zipcode field with "60604"
		And I fill in the shipping state field with "IL"
		And I select "IL" from the state dropdown menu
		When I click the "Estimate shipping" button
		Then I should see an alert "Our system shows that address as invalid. Proceed anyway?"

	(sad path)
	Scenario: User enters no address
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping city field with "Chicago"
		And I fill in the shipping zipcode field with "60604"
		And I fill in the shipping state field with "IL"
		When I click the "Estimate shipping" button
		Then I should see "Please fill out all required fields"

	Scenario: User enters no city
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "175 W Jackson Blvd"
		And I fill in the shipping state field with "IL"
		When I click the "Estimate shipping" button
		Then I should see "Please fill out all required fields"

	Scenario: User enters no state
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "175 W Jackson Blvd"
		And I fill in the shipping city field with "Chicago"
		And I fill in the shipping zipcode field with "60604"
		When I click the "Estimate shipping" button
		Then I should see "Please fill out all required fields"

	Scenario: User enters no zipcode
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "175 W Jackson Blvd"
		And I fill in the shipping city field with "Chicago"
		And I fill in the shipping state field with "IL"
		When I click the "Estimate shipping" button
		Then I should see "Please fill out all required fields"

	Scenario: User enters more than 70 characters in the shipping address field
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "1178728179287sdfklj3311178728179287sdfklj3311178728179287sdfklj3311178728179287sdfklj3311178728179287sdfklj3311178728179287sdfklj3313311178728179287sdfklj333311178728179287sdfklj33"
		And I fill in the shipping city field with "Chicago"
		And I fill in the shipping state field with "IL"
		And I fill in the shipping zipcode field with "60604"
		When I click the "Estimate shipping" button
		Then I should see "Please enter a shipping address under 70 characters"

	Scenario: User enters more than 30 characters in the shipping city field
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "175 W. Jackson Blvd"
		And I fill in the shipping city field with "Chicagooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
		And I fill in the shipping state field with "IL"
		And I fill in the shipping zipcode field with "60604"
		When I click the "Estimate shipping" button
		Then I should see "Please enter a shipping address under 70 characters"

	Scenario: User enters zipcode that is not exactly 5 integers
		Given that I have 1 Broomstick in my cart
		And I am on the checkout page
		And I fill in the shipping address field with "175 W. Jackson Blvd"
		And I fill in the shipping city field with "Chicago"
		And I fill in the shipping state field with "IL"
		And I fill in the shipping zipcode field with "6060442242424hello"
		When I click the "Estimate shipping" button
		Then I should see "Please enter a shipping address under 70 characters"