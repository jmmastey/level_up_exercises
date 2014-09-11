Feature: A user can be logged in or anonymous
  As a user
  I can choose to either log in or make my transactions as an anonymous user
  So that I don't have to undergo the hassle of siging up for the services if I'm certain I'm not going to be re-using the service

  Scenario: Anonymous users can operate the cart just as a logged in user
  Given I am not logged in
  Then should be able to perform all basic operations that logged in users can

  Scenario: The shopping cart is saved for logged in users
  Given I am registered user
  When I am logged in
  And I make some changes to my shopping cart
  And I log out
  And I log back in
  Then I should be able to see all changes I had made to my cart

  Scenario: An anonymous user's shopping cart is merged on log in
  Given I am registered user
  When I am not logged in
  And I make changes to my shopping cart as an anonymous user's shopping cart
  And I log in
  Then my anonymous cart's changes must be merged in with my saved cart

  Scenario: Shopping cart is auto updated on log in
  Given I am a registered user
  When I am not logged in
  And some items in my cart have changed in price
  And some items in my cart have gone out of stock
  And some of my coupons are no longer valid
  And I log in
  Then my cart should have been updated to reflect the same
  And I am shown a notification regarding the same

  Scenario: An anonymous user's shopping cart expires when session times out
  Given I am not logged in
  When I make changes to my shopping cart
  And I end my browsing session
  And I return to the shopping cart
  Then my shopping cart should have been cleared of all my previous transactions
