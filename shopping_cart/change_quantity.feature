Feature: Change Quantity of Products in Shopping Cart
  As a customer
  I want to change the number of products in my shopping cart
  In order to purchase the correct amount

  Background
    Given I am on the Shopping Cart page

  Scenario: Update the Quantity of a Product (Good Path)
    Given I have added a "hammer" to my cart
    When I enter 2 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should have 2 hammers in my cart

  Scenario: Update the Quantity of a Product that is Out of Stock (Sad Path)
    Given I have added a "screwdriver" to my cart
    When I enter 2 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should see "We are sorry. That item is now out of stock."

  Scenario: Update the Quantity of a Product to a Negative Amount (Bad Path)
    Given I have added a "hammer" to my cart
    When I enter -5 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should see "Invalid Quantity. Please enter a number greater than zero."
