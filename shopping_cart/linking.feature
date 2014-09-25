Feature: Linking back to items
  In order to purchase items online
  As an online shopper
  I want to be able to get back to product pages from my cart

  Background: My cart already contains some items
    Given my cart contains 3 pairs of socks
    And my cart contains 1 pair of jeans

  Scenario: Returning to items
    Given I'm on the "Shopping Cart" page
    When I click "Fancy Jeans"
    Then I should be on the "Fancy Jeans" product page
    And I should see a description for "Fancy Jeans"
    And I should not see "Crazy Socks"

  Scenario: Accessing shopping cart page
    Given I'm on the "Fancy Jeans" page
    When I click "Shopping Cart"
    Then I should see "Fancy Jeans"
    And I should see "Crazy Socks"
    And I should see "Total Quantity"