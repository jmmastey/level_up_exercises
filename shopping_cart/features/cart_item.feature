#Add
@Happy
Scenario: Adding a product
  When I type in a SKU in the sku field
  And I click the add button
  And Set the quantity field is not at 0
  Then the product is added to the cart with the quantity of the field
  When the product already exist in the cart
  Then the product quantity is incremented by quantity

#Delete
@Happy
Scenario: Deleting a product
  Given that the cart contains at least one product
  When I click on the deleting button of the product line
  Then the product is deleted
  Then the order totals are recalculated

#Edit
@Happy
Scenario: Changing the quantity of the product
  When I enter a new quantity that is superior or equal to 1
  Then the product's quantity is updated.
  Then the line price is recalculated
  Then the order totals are recalculated
  When I enter a new quantity inferior than 1
  Then the product is deleted
  Then the line price is recalculated
  Then the order totals are recalculated

@Bad
Scenario: Changing the quantity of the product with non-numeric data
  When I enter a new quantity that is not non-numeric
  Then the edit is aborted
  And nothing is edited

#Product Page Access
@Happy
Scenario: Accessing product page from cart
  Given that the cart contains at least one product
  When I click on the product name
  Then the product page is loaded and displayed

@Sad
Scenario: Accessing non existing product page from cart
  Given that the cart contains at least one product
  When I click on the product name
  And the product page does not exist
  Then show a 404 error with option to return to cart
