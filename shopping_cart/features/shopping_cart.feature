Feature: using our shopping cart
  In order to make purchases from our website
  A user makes use of their cart


   Scenario: a visitor can only set the quantity to a number
     Given a user that is logged in
     When they add a product to their cart
     And they then remove the product from their cart
     Then the item is no longer in their cart


   Scenario: a user clicks on the name of a product in the cart
     Given a user that is logged in
     When they add a product to their cart
     And they click on the products name
     Then they are shown that products page

   Scenario: the cart calculates the shipping cost
     Given a user that is logged in
     When they add a product to their cart
     And enter their shipping information
     Then they are shown the cost of shipping the items in their cart to them
