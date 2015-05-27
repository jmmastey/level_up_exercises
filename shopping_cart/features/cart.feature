Feature: Shopping Cart

Scenario: Viewing an empty Cart (new user)
  Given I am a User with no previous site sessions
    And I am viewing the Cart page
  Then I see messaging telling me that the Cart is currently empty

Scenario: Viewing an empty Cart (no items)
  Given I am a User
    And I am viewing the Cart page
    And there are 0 items in the Cart
  Then I see messaging telling me that the Cart is currently empty

Scenario: View order totals
  Given I am an User
    And I am viewing the Cart page
    And I have 1 or more Items in my Cart
  Then the subtotal displayed is a total of all Items in my Cart (before tax and minus discounts)
    And the total displayed is a total of all Items in my Cart (after tax)

Scenario: Revisiting a previous Cart
  Given I am a User with a previous site session
    And I have a Items in my Cart from a previous session
  Then the contents of my previous Cart remain as part of my current Cart
    And the order totals are updated accordingly

Scenario: User adds Items to the Cart
  Given I am a User
    And I am viewing an Item page
  When I click "Add To Cart"
  Then the quantity of the corresponding Item in my Cart increases by the number selected in the "Quantity" dropdown
    And the order totals are updated accordingly

Scenario: User removes Item from the Cart
  Given I am a User
    And I am viewing the Cart page
    And I have 1 or more Items in my Cart
  When I click one of the "Remove From Cart" buttons
  Then the corresponding Item is removed form my Cart completely
    And the order totals are updated accordingly

Scenario: User changes product quantities in the Cart
  Given I am a User
    And I am viewing the Cart page
    And I have 1 or more Items in my Cart
    And I make one or more changes to the "Quantity" dropdowns
  When I click the "Update Cart" button
  Then the all of the Item quantities update to reflect the numbers selected in the corresponding "Quantity" dropdowns
    And the order totals are updated accordingly

Scenario: User views product information for Items in the Cart
  Given I am a User
    And I am viewing the Cart page
    And I have 1 or more Items in my Cart
  When I click an Item's title
  Then I am taken to the corresponding Item page
