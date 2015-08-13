Ability: Viewing Product Information from Cart

  As a customer
  I need the ability to go back to product pages from my cart products
  So that I can do further investigation on the product if necessary

  Background:
    Given an authenticated customer

  Scenario: Product pages from cart with existing products
    Given a cart with a product
    When the customer views product information
    Then the customer is taken to the product page

  Scenario: Product pages from cart with no-longer sold products
    Given a cart with a product that is no longer sold
    When the customer views the product in the cart
    Then the customer will see a product no longer sold message
    And the product page for the product will not be available

  Scenario: Product pages from cart with sold out products
    Given a cart with a product that is sold out
    When the customer views the product in the cart
    Then the customer will see a sold out message
    But the product page will be available

  Scenario: Product pages from cart with products that have changed price
    Given a cart with a product that costs $20.00
    And the product is now $10.00 on the site
    When the customer views the product in the cart
    Then the customer will see a price has changed message
    And the total cost of the cart will reflect the new product price
