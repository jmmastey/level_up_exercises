Feature: Remove Product
  As a user
  I want to be able to remove products from my cart

  Background:
    Given I view my cart
    And I have <quantity> <product>

  Scenario Outline: Remove product
    When I click remove for <product>
    Then I expect not to have <product> in my cart

  Scenario Outline: Change quantity to 0
    When I change quantity for <product> to 0
    And click update
    Then I expect not to have <product> in my cart

  Scenario Outline: Fail to remove via invalid quantity
    When I change quantity for <product> to an invalid <quantity>
    And click update
    Then I expect to have a quantity error
    And to have <product> in my cart
