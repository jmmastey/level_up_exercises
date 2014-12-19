Feature: Add items to the shopping cart
  As an online customer
  I should be able to add item/items to the cart
  So that I can checkout and purchase them

Background:
  Given the shopping cart is empty

Scenario Outline: I add an item to the shopping cart
  When I add "<number_of>" of "<item>" to the cart
  Then I should see the cart shows "<number_of>" of "<item>" 
  And I should see the message "<message>"

@happy
Examples:
|  number_of  |  item    |        message                |
|    1        | Item_A   | One item ready for checkout   |
|    2        | Item_B   | Two items ready for checkout  |

@bad
Examples:
|  number_of  |  item    |        message                |
|    -1       | Item_A   | No items in the cart          |
|     1       |          | Please select a valid item    |

@sad
Examples:
|  number_of  |  item    |        message                |
|    0        | Item_A   | No items in cart to checkout  |

@happy
Scenario: Add item as anonymous user and then login as registered user
  Given I am an anonymous user
  And I add "item_1" to the cart
  When I login as a registered user "user_1"
  And I add "item_2" to the cart
  Then I should see the cart shows "item_1" and "item_2" 
  And I should see the message "Items ready for checkout"

@happy
Scenario: Add item as registered user and then logout
  When I login as a registered user "user_1"
  And I add "item_1" to the cart
  Then I logout "user_1"
  And I should see the cart shows no items

@happy
Scenario: Add an item as anonymous user and then add same item as registered user
  Given as an anonymous user I add "item_1" to the cart
  When I login as a registered user "user_1"
  And I add "item_1" to the cart
  Then I should see the cart shows 2 quantities of "item_1"
  And I should see the message "Items ready for checkout"
