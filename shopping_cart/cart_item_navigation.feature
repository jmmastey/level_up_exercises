Feature: Navigate to/from shopping cart

  In order to navigate from the shopping cart
  As the customer
  I should click on products or shopping cart

  Scenario: navigate to specific item using name link
    Given I am on the cart page
    When I click on the name of an item
    Then I see the item page

  Scenario: navigate to specific item using picture of item
    Given I am on the cart page
    When I click on the picture of an item
    Then I see the item page

  Scenario: navigate to shopping cart from item page
    Given I am on an item page
    When I click on the cart icon
    Then I see the cart page
