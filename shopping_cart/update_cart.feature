Feature: Update items on the shopping cart
  As an online customer
  I should be able to update items on the cart
  So that I checkout only what is needed

Scenario Outline: I update the item/items on the cart
Given the shopping cart is empty
When I add "<number_of>" of "<item>" to the cart
And I update the "<update_number>" of the item
Then I should see the cart shows "<total>" of "<item>"
And I should see the message "<message>"

@happy
Examples:
|  number_of  |  item  |  update_number  | total  |       message                  |
|      1      | Item_A |      2          |   3    | Three items ready for checkout |
|      2      | Item_B |     -1          |   1    | One item ready for checkout    |

@bad
Examples:
|  number_of  |  item  |  update_number  | total  |       message                  |
|      1      | Item_A |     -2          |   0    | Please select valid quantity   |
|      1      |        |      1          |   0    | Please select valid item       |
|      0      | Item_B |     -1          |   0    | Please select valid quantity   |

@sad
Examples:
|  number_of  |  item  |  update_number  | total  |       message                  |
|      0      | Item_A |      0          |   0    | No items in cart to update     |
