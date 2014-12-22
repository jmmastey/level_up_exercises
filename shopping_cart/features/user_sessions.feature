Feature: User session persists
	# There is a LOT of concepts to check for in here:
	# Sessions should probably be their own entire testing suite it seems...

	Scenario: I log into my exisiting account and I see my cart with exisiting items still in its fucking place
		Given a anonymous user with exisiting login credentials
		And an existing shopping cart with items
		When they log into their account
		Then they should be see the items in their cart that were there previously

	Scenario: Anononymous browsing cart appends to authenticated cart
		Given a non-logged in user who has login credentials
		And a cart with mutiple items added during an anonymous session
		And a cart with mutiple items that exists within the users logged in cart
		When the user logs in
		Then they should see their cart of items from their anonymous session appended to their cart from their logged in session

	Scenario: Cart is saved to profile
		Given a non-logged in user who has items saved in their cart in their profile
		When they log in
		They should see their cart filled with the items they had previously saved to their cart

	Scenario: Non-logged in user can checkout without logging in
		Given a non-logged in user
		And a a non-empty cart
		Then they should be able to check out without logging in

	Scenario: A non-logged in user with items in their cart can log in and maintain their cart
		Given a non-logged in user
		And a non-empty cart
		When they log in
		Then the items in their cart should continue to be there

	Scenario: An anonymous user with a non-empty cart can sign up and maintain their cart
		Given an anonymous user
		And a non-empty cart
		When they sign up
		Then the items in their cart should continue to be there

	Scenario: An anonymous user with a non-empty cart can reload and maintain their cart
		Given an anonymous user
		And a non-empty cart
		When they reload their browser
		And they have not deleted their cookies
		Then the items in their cart should continue to be there

	Scenario: An anonymous user with a non-empty cart can leave the page, return, and still maintain their cart
		Given an anonymous user
		And a non-empty cart
		When they visit another page in the browser
		And they return to our webpage
		And have not deleted their cookies
		Then the items in their cart should continue to be there

	Scenario: An anonymous user with a non-empty cart can restart broswer and maintain their cart
		Given an anonymous user
		And a non-empty cart
		When they restart their browser
		And they have not deleted their cookies
		Then the items in their cart should continue to be there
