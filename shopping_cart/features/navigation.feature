Feature: Navigate to product page from cart
  As a shopper
  In order to see the product detais after adding item to the cart
  I want to navigate to product page by clicking the item line

  @happy
  Scenario: navigate from the cart
    Given I am on the shopping cart page
      And the cart has 3 units of Item A
    When I click on the item line of the Item A
    Then I should be in the product page of Item A
