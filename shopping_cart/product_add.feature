Feature: Add Product
  As a user
  I want to be able to add products to my cart

  Scenario Outline: Add product to cart
    Given I view <product>
    When I enter in <quantity>
    And click buy
    Then I expect to have <quantity> <product> in my cart

  Scenario Outline: Default quantity 1
    Given I view <product>
    When I click buy
    Then I expect to have 1 <product> in my cart

  Scenario Outline: Invalid quantity
    Given I view <product>
    When I enter in an invalid <quantity>
    And click buy
    Then I expect to have a quantity error

  Scenario Outline: Invalid product page
    Given <product> is an old listing or invalid listing
    When I try to view the <product> page
    Then I expect to have a listing error
