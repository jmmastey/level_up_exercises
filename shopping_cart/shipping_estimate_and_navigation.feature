Feature: Add address to get shipping estimates and confirm item page navigation
  As an online customer
  I should be able to navigate to item page from the cart
  And also be able to add address information
  So that I can easily navigate pages and get shipping estimates

@happy
Scenario: I should view the item page when I click on item from cart
  Given that I have 1 quantity of "item_A" in the cart
  When I click on "item_A"
  Then I should see the description and details of "item_A"

Scenario Outline: I add address information to get shipping estimates
  Given that I have 1 quantity of "item_A" in the cart
  When I enter "<address>" in the address field
  And I enter "<zip_code>" in the zip code field
  Then I should see the cart shows "<shipping_total>" in the shipping estimate
  And I should see the "<message>"

@happy
Examples:
|   address        |  zip_code  |  shipping_total  |           message              |
| 123 main street  |   60606    |    $4.99         | Your shipping cost is as shown |

@bad
Examples:
|   address        |  zip_code  |  shipping_total  |           message                                       |
| ABCDEFGHIJ       |  1111      |    $0.00         | Please provide valid address and zip for valid estimate |
| 1234567890       |            |    $0.00         | Please provide valid address and zip for valid estimate |

@sad
Examples:
|   address        |  zip_code  |  shipping_total  |           message                                 |
|                  |            |    $0.00         | Please provide address and zip for valid estimate |
