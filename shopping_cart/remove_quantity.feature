Feature: Remove Products from Shopping Cart
  As a customer
  I want to remove products from my shopping cart
  In order to not purchase them

  Scenario: Remove Product From Cart (Good Path)
    Given I have added a product to my cart
    And I am on the Shopping Cart page
    When I click "Remove Product"
    Then I should have 0 products in my cart

  # There are no Sad or Bad Paths for this Feature
