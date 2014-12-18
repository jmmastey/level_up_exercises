Feature: Update the shopping cart

  Scenario Outline: I update product quantity 
    Given I have 1 "<product>" in shopping cart
    When I change quantity of "<product >" to "<qty>"
    Then I should see "<message>"
    Then the total item should be "<total_items>"
    And the subtotal should be "<subtotal>" 

@happy
  Examples:
    | product     | qty | subtotal | total | msg
    | Paint Brush |   2 |    4.00  | 4.00  | 2 item is in cart

@sad
  Examples:
    | product     | qty | subtotal | total | msg
    | Paint Brush |   1 |    2.00  | 2.00  | Sorry We are out of stock only 1 left!

@bad
  Examples:
    | product     | qty  | subtotal | total | msg
    | Paint Brush |   -1 |    2.00  | 2.00  |please enter valid quantity
    | Paint Brush |   b  |    2.00  | 2.00  |invalid entry!

Background:
        Given I add "Paint Brush" to cart
        And I add "oil colors" to cart

@happy
  Scenario: Remove product
    When I remove "paint brush"
    Then I should see only "oil colors" in the cart
    AND subtotal and total should be updated 

@happy
  Scenario: Remove all products from shopping cart
    When I empty shopping cart
    Then I should see 0 products in shopping cart
    And I should see subtotal and total would be $0.00
