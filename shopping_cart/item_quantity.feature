Feature: Select an Item
   In order to test the shopping_cart application
   As a developer who plans to write it
   I want to test adding an item, removing an item, and changing item quantity 

   Background:
     User visits page for item Sriver-3MM-Red

   Scenario: Add item to cart
     When the user adds 1 Sriver-3MM-Red
     Then cart should contain 1 Sriver-3MM-Red

   Scenario: Add quantity of item to cart
     When the user adds 3 Sriver-3MM-Red
     Then cart should contain 3 Sriver-3MM-Red

   Scenario: Change quantity of item in cart
     When the user adds 1 Sriver-3MM-Red
     And the user changes the quantity of Sriver-3MM-Red to 5
     Then cart should contain 5 Sriver-3MM-Red

   Scenario: Add item to cart
     When the user adds 1 Sriver-3MM-Red
     And the user removes Sriver-3MM-Red
     Then cart should not contain Sriver-3MM-Red

   Scenario: Remove an item not in the cart
     When the user removes Sriver-3MM-Red
     Then cart should not contain Sriver-3MM-Red
     And user should see error message "Item not in cart"

