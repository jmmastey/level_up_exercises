Feature: Clicking an item leads to it's product page
  As a customer
  I can click on items in the cart and see their page
  In order to buy necessary goods

  Background: I have items in my cart
    Given: I have items in my shopping cart

  @Happy
  Scenario: When I click on a shopping cart item, it should redirect me to it's webpage
    When I click on the first item
    Then I should be on the first item's page

  @Sad
  Scenario: I can't have removed items in my cart
    And an item in my cart has since been removed from the store
    When I try to click the item page
    Then I should see an error that the item has been deleted