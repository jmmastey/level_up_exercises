Feature: Persisting Sessions
   In order to test the shopping_cart application
   As a customer who plans to use it
   I want to test persistence of my cart across login sessions

   Scenario: User logs in for the first time
     Given user logs in as Shinigami
     Then user should see 0 items in cart

   Scenario: User adds items then logs out and back in
     Given user logs in as Shinigami
     And user adds 3 items to cart
     And user logs out and re-logs in as Shinigami
     Then user should see 3 items in cart

   Scenario: User adds items then logs out and back in a someone else
     Given user logs in as Shinigami
     And user adds 3 items to cart
     And user logs out and re-logs in as Izanami
     Then user should see 0 items in cart

   Scenario: Anonymous user adds items then logs in as user
     Given anonymous user with items
     And user logs in as Shinigami
     Then user should see 0 items in cart
