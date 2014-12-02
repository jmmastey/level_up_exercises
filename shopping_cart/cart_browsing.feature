Feature: Cart Browsing
   In order to test the shopping_cart application
   As a developer who plans to write it
   I want ensure a user can browse the items in the cart

   Background:
     Given Cart holds 3 Sriver-3MM-Red
     And Cart holds 4 Dozen-Nittaku-Yellow
     And Cart holds 1 Yasaka-Stress-Net
     And user vists summary page

   Scenario: User selects item in list
     When user clicks on item Sriver-3MM-Red
     Then user should see item-details for Sriver-3MM-Red

   Scenario: User selects item in list
     When user clicks on item Dozen-Nittaku-Yellow
     Then user should see item-details for Dozen-Nittaku-Yellow

   Scenario: User selects item in list
     When user clicks on item Yasaka-Stress-Net
     Then user should see item-details for Yasaka-Stress-Net
