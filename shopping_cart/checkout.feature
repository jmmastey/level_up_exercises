Feature: Checking Out
   In order to test the shopping_cart application
   As a developer who plans to write it
   I want ensure a user can checkout

   Background:
     Given Cart holds 3 Sriver-3MM-Red
     And Cart holds 4 Dozen-Nittaku-Yellow
     And Cart holds 1 Yasaka-Stress-Net
     And user vists the checkout page

   Scenario: User should see the correct total
     Then user should see a total cost of 250.09

   Scenario: User proceeds to checkout
     When user clicks checkout
     Then user is directed to payment page

   Scenario: User applies a coupon
     When user applies a coupon
     Then user should see a total cost of 220.09

   Scenario: User tries to apply an unrecognized coupon
     When user applies an unrecognized coupon
     Then user should see a unrecognized coupon message

   Scenario: User tries to apply an expired coupon
     When user applies an expired coupon
     Then user should see a expired coupon message
