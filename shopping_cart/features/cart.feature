Feature: Shopping Cart

Scenario: Viewing an empty Cart
  Given I am a User
    And my Cart is empty
  When I view the Cart page
  Then I see messaging telling me that the Cart is currently empty

Scenario: View order totals
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
  Then I my subtotal is $20.00
    And my total is $25.00

Scenario: Revisiting a previous Cart
  Given I am a User
    And I have previous Cart data in my cookie
  When I view the Cart page
  Then I see the contents of my previous Cart

Scenario: User adds Items to the Cart
  Given I am a User
    And my Cart is empty
  When I am view the Widget product page
    And I click "Add To Cart"
  Then I have one Widget in my Cart
    And my subtotal is $10.00
    And my total is $15.00

Scenario: User removes Item from the Cart
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I click "Remove From Cart"
  Then I have no Widgets in my Cart
    And my subtotal is $0.00
    And my total is $0.00

Scenario: User changes product quantities in the Cart
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I change the "Quantity" dropdown to 4
    And I click the "Update Cart" button
  Then I have 4 Widgets in my Cart
    And my subtotal is $40.00
    And my total is $45.00

Scenario: User views product information for Items in the Cart
  Given I am a User with 2 Widgets in my Cart
  When I view the Cart page
    And I click the Widget's title
  Then I am taken to the Widget product page
