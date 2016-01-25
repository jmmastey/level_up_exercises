Feature: When anonymous user logs in, her cart is merged with her account's saved cart
	As a user
	I want to merge my cart while I browse anonymously with my saved account cart when I login
	So I don't lose the items I've been amassing while shopping

	Scenario: Anonymous user logs in with items in cart. Her account also has items saved in its cart
		Given that I am not logged in
		And I have 1 Broomstick and 1 Wand in my cart
		And my login account has 2 Broomsticks and 1 Textbook in its cart
		When I log in
		And I visit the shopping cart page
		Then I should see "3 Broomsticks"
		And I should see "1 Wand"
		And I should see "1 Textbook" 

	Scenario: Anonymous user enters wrong information
		Given that I am not logged in
		And I have 1 Broomstick and 1 Wand in my cart
		And my login account has 2 Broomsticks and 1 Textbook in its cart
		When I try to log in and fail
		Then I should see "Invalid credentials"
		When I visit the shopping cart page
		Then I should see "1 Broomstick"
		And I should see "1 Wand"