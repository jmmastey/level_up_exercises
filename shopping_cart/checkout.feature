Feature: Checking Out
   In order to test the shopping_cart application
   As a customer who plans to use it
   I want ensure a user can checkout

   Background:
     Given the cart holds 3 Sriver-3MM-Red
     And the cart holds 4 Dozen-Nittaku-Yellow
     And the cart holds 1 Yasaka-Stress-Net
     And the user visits the checkout page

   Scenario: The user should see the correct total
     Then the user should see a total cost of 250.09

   Scenario: The user proceeds to checkout
     When the user clicks checkout
     Then the user is directed to payment page

   Scenario: The user applies a coupon
     When the user applies a coupon
     Then the user should see a total cost of 220.09

   Scenario: The user tries to apply an unrecognized coupon
     When the user applies an unrecognized coupon
     Then the user should see an unrecognized coupon message

   Scenario: The user tries to apply an expired coupon
     When the user applies an expired coupon
     Then the user should see an expired coupon message
