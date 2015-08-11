Feature: Shopping Cart Checkout
  In order to change quantities
  As a shopper
  I should be able to delete and add items

  Background:
    Given I am viewing "checkout"

  Scenario Outline: Changing Shopping Cart quantities
    Given I am viewing the shopping cart
    And the user has 1 soap in their cart
    Then I want to <change> soap <quantities>

    Examples:
    | change   | quantities |
    | add      | 2          |
    | subtract | 1          |
    | delete   | 0          |
