Feature: User can modify quantities of items currently in cart
  As a user
  I want to be able to modify the number of items in my cart
  So that I can conveniently control the quantities of items in my cart

  Scenario: Can change the quantity of item in cart
  Given that I have an item in my shopping cart
  When I click on the dropdown to select its quantity
  Then I should be able to select a number >= 1

  Scenario: Can delete an item from the cart
  Given that I have an item in my shopping cart
  When I click on the delete link on the item
  Then the item is removed from my cart

  Scenario: Can only add as many of a given item as in stock
  Given that I have an item in my shopping cart
  When I click on the dropdown to select its quantity
  Then I can only add as many of the item as available in stock

  Scenario: Cannot change quantity of item once deleted
  Given that I have an item in my shopping cart
  When I click on the delete link on the item
  Then the item is removed from view
  And I cannot change the quantity of the item using the dropdown

  Scenario: Adding the same item changes quantity
  Given that I have an item in my shopping cart
  When I click on add to cart from the item's page
  Then I see the item's quantity increase by one in my shopping cart

  Scenario: I cannot add the item unless it's in stock
  Given I am viewing an item
  When the item is out of stock
  Then I should not see an add to cart link

  Scenario: I can navigate to an item's page from the cart
  Given that I have an item in my shopping cart
  When I click on the item
  Then I should be taken to the item's page
