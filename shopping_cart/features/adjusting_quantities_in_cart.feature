Feature: adjusting the quantity of items in their cart
  In order to order only want they want
  A user can adjust the quanity of products in their cart


  Scenario: a user adjusts the quantity of an item in the cart upward
    Given a user that is logged in
    When they add a product to their cart
    And they then adjust the quantity of that product upwards
    Then the cart reflects the new quantity

  Scenario: a user adjusts the quantity of an item in the cart downward
    Given a user that is logged in
    When they add a product to their cart
    And they then adjust the quantity of that product downwards
    Then the cart reflects the new quantity

  Scenario: a user can't lower the quantity of a product below zero
    Given a user that is logged in
    When they add a product to their cart
    And they then adjust the quantity of that product downwards
    Then the interface won't allow them to set the quantity less then 0

  Scenario: a user can only set the quantity to a number
    Given a user that is logged in
    When they add a product to their cart
    And they then adjust the quantity of that product to 'ABCD'
    Then the interface won't allow them to set the quantity to anything not numeric
