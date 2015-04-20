Feature: View item
  In order to review item details 
  As a online customer
  I want to get back to the item page from the cart

#Happy Path
  Scenario: view item details
    Given I have an item in the shopping cart
    When I click on the item line 
    Then I should see the item details