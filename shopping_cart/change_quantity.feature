Feature: Change Quantity of Products in Shopping Cart
  As a customer
  I want to change the number of products in my shopping cart
  In order to purchase the correct amount

  Background
    Given I have added a product to my cart
    And I am on the Shopping Cart page

  Scenario: Update the Quantity of a Product (Good Path)
    When I enter 2 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should have 2 products in my cart

  Scenario: Update the Quantity of a Product to a Negative Amount (Bad Path)
    When I enter -5 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should see "Invalid Quantity. Please enter a number greater than zero."
