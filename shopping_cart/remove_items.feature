Feature: Delete items from the shopping cart
  As an online customer
  I should be able to remove item/items from the cart
  So that I can checkout only what I want

Background:
  Given I have an empty shopping cart

Scenario Outline: I remove item/items from the cart before checkout
  Given I add "<number_of_item_1>" "item_1" to the cart
  When I remove "<delete_item_1>" "item_1" from the cart
  Then I should see the cart shows "<number_of_item_1>" "item_1" and "<message>"

@happy
Examples:
| number_of_item_1 | delete_item_1 |       message             |
|       1          |        1      | You have no items in cart |
|       2          |        1      | You have one item in cart |

@bad
Examples:
| number_of_item_1 | delete_item_1 |       message                          |
|       1          |        2      | Select valid number of items to remove |

@sad
Examples:
| number_of_item_1 | delete_item_1 |       message                          |
|       0          |        1      | You have no items in cart to remove    |

@bad
Scenario: I remove same item twice from the cart
  Given I add 2 quantities of "item_1" to the cart
  When I remove 1 quantity of "item_1" from the cart
  And I remove 2 quantities of "item_1" from the cart
  Then I should see the cart shows message "Select valid number of items to remove"

