Feature: Change Quantity of Products in Shopping Cart
  As a customer
  I want to change the number of products in my shopping cart
  In order to purchase the correct amount

  Background
    Given I am on the Shopping Cart page
    And I am logged in

  Scenario: Update the Quantity of a Product (Good Path)
    Given I have added 1 hammer to my cart
    And 10 hammers are in stock
    And the total cost is $10.00
    When I enter 2 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should have 2 hammers in my cart
    And the total cost is $20.00

  Scenario: Update the Quantity of a Product where items are Out of Stock (Sad Path)
    Given I have added 1 screwdriver to my cart
    And 0 screwdrivers are in stock
    And the total cost is $5.00
    When I enter 2 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should see "We are out of stock and can't fulfill your order for this item."
    And the total cost is $0.00

  Scenario: Update the Quantity of a Product to an amount greater than is available (Sad Path)
    Given I have added 1 hammer to my cart
    And there are 5 hammers in stock
    And the total cost is $10.00
    When I enter 10 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should have 6 hammers in my cart
    And the total cost is $60.00
    Then I should see "We could only add 5 hammers to your cart as we are now out of stock"

  Scenario: Update the Quantity of a Product to a Negative Amount (Bad Path)
    Given I have added 1 hammer to my cart
    And 10 hammers are in stock
    And the total cost is $10.00
    When I enter -5 in the "Update Quantity" box
    And I click "Update Quantity"
    Then I should see "Invalid Quantity. Please enter a number greater than zero."
    And the total cost is $10.00
