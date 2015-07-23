Feature: Product listing
  As a user
  I want to be able to view the product page from the shopping cart

  Background:
    Given I view my cart
    And I have products in my cart

  Scenario Outline: View product listing page from cart
    When I click on the product link for <product>
    Then I expect to see the listing page for <product>

  Scenario Outline: Invalid product in cart
    When I click on the product link for <product>
    And the <product> is outdated or invalid
    Then I expect to have a listing error
    And I should not have <product> in my cart