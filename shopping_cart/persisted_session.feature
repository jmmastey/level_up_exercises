Feature: Persisting Sessions
   In order to test the shopping_cart application
   As a customer who plans to use it
   I want to test persistence of my cart across login sessions

   Scenario: The user logs in for the first time
     Given the user logs in as Shinigami
     Then the user should see 0 items in cart

   Scenario: User adds items then logs out and back in
     Given the user logs in as Shinigami
     And the user adds 3 items to cart
     And the user logs out
     And the user logs in as Shinigami
     Then the user should see 3 items in the cart

   Scenario: The user adds items then logs out and back in as someone else
     Given the user logs in as Shinigami
     And the user adds 3 items to the cart
     And the user logs out
     And the user logs in as Izanami
     Then the user should see 0 items in the cart

   Scenario: An anonymous user adds items then logs in
     Given an anonymous user with items in their cart
     And the user logs in as Shinigami
     Then the user should see items in the cart

   Scenario: Anonymous user adds to cart then logs in and sees a merged cart with combined items
     Given the user Shinigami has 3 items in their cart
     And an anonymous user adds 2 items to their cart
     And the user logs in as Shinigami
     Then the user should see 5 items in their cart
