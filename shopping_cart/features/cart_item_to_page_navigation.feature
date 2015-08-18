Feature: Navigating to items product page
  In order to quickly remind myself about some of the product details
  As an online shopper
  I want to be able to click on my cart items to see their full product page

  Background:
    Given I have 3 items in my shopping cart

  Scenario: Adding an item to an empty cart
    When I click the first item's product page link
    Then I should be on the first item's product page

  Scenario: Navigating to expired product
    And the first item no longer exists
    When I click the first item's product page link
    Then I should receive a product missing warning
    And the cart should have 2 items each with quantity 1
    