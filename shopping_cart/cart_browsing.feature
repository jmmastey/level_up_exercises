Feature: Cart Browsing
   In order to test the shopping_cart application
   As a customer who plans to use it
   I want ensure a user can browse the items in the cart

   Background:
     Given the cart holds 1 <item>
     And the user visits the summary page
     When the user clicks on item <item>
     Then the user should see item-details for <item>

   Examples:
     |item                |
     |Sriver-3MM-Red      |
     |Dozen-Nittaku-Yellow|
     |Yasaka-Stress-Net   |
