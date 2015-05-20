Feature: Navigate to/from shopping cart

  In order to navigate from the shopping cart
  As the customer
  I should click on products or shopping cart

  Scenario: navigate to specific item using name link
    Given I am on the cart page
    When I click on JellyBelly link in the cart
    Then I see the item page

  Scenario: navigate to specific item using picture of item
    Given I am on the cart page
    When I click on the picture of JellyBelly item
    Then I see the item page

  Scenario: navigate to shopping cart from item page
    Given I am on the Nerds Candy item page
    When I click on the cart icon
    Then I see the cart page
