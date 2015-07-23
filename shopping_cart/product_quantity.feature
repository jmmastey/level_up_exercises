Feature: Update Product Quantity
  As a user
  I want to be able to update the quantity of products in my cart

  Background:
    Given I view my cart
    And add some products

  Scenario Outline: Update quantity for 1 product at a time
    When I change the quantity of <product> to <quantity>
    And click update
    Then I expect to have <quantity> <product>
    And the same amount of all other products

  Scenario Outline: Update quantity for multiple products at a time
    When I change the quantity of <product1> to <quantity1>
    And I change the quantity of <product2> to <quantity2>
    Then I expect to have <quantity1> <product1>
    And I expect to have <quantity2> <product2>
    And the same amount of all other products

  Scenario Outline: Update invalid quantity for 1 product at a time
    When I change the quantity of <product> to <quantity>
    And click update
    Then I expect to have <quantity> <product>
    And the same amount of all other products

  Scenario Outline: Update invalid quantity for multiple products at a time
    When I change the quantity of <product1> to <quantity1>
    And I change the quantity of <product2> to <quantity2>
    Then I expect to have <quantity1> <product1>
    And I expect to have <quantity2> <product2>
    And the same amount of all other products