Feature: Shipping Estimate
   In order to test the shopping_cart application
   As a customer who plans to use it
   I want ensure a user can see shipping estimates

   Background:
     Given the cart has items
     And the user visits the shipping page

   Scenario: Shipping estimates for 90210
     When the user enters zip-code 90210
     Then the user should see a shipping estimate of 15.00

   Scenario: User enters non-domestic U.S. zip-code
     When the user enters zip-code 96701
     Then the user should see "Shipping Not Available"

   Scenario: User enters invalid zip-code and should see error message
     When the user enters zip-code 99999
     Then user should see "Invalid Zip-Code"
