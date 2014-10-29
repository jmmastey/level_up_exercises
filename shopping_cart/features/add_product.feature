Feature: Shopping Cart
  A simple shopping cart that allows people to add a item to a cart
  and then on those items be able to add, remove or change quantities.

  The shopping cart should provide shipping estimates on items without
  forcing the user to checkout. Additionally, the user should be allowed
  to add unexpired coupons and have the new price reflected for the item
  once the coupons have been applied.

  The user's cart can have 2 states: a cart with items when the user is not
  logged in, and a cart from a previous session.

  Background:
    Given I have a empty shopping cart
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $30.00

  Scenario Outline: Add a product to the shopping cart as a anonymous user
    When I add <quantity> of "<item>" to shopping cart
    Then I should see <item_total> of "<item>" in shopping cart
    And I should see $<item_price> of "<item>" in shopping cart
    And I should see items subtotal of $<cart_subtotal> in shopping cart

  @happy_path
  Examples:
    | quantity | item   | item_total | item_price | cart_subtotal |
    | 1        | Item 1 | 1          | 10.00      | 10.00         |
    | 5        | Item 1 | 5          | 10.00      | 50.00         |

  @sad_path
  Examples:
    | quantity | item   | item_total | item_price | cart_subtotal |
    | 0        | Item 1 | 1          | 10.00      | 10.00         |
    | 5        | Item 2 | 5          | 100.00     | 100.00        |

  @bad_path
  Examples:
    | quantity | item   | item_total | item_price | cart_subtotal |
    | -1       | Item 1 | 1          | 10.00      | 10.00         |

  @happy_path
  Scenario: Add a product to the shopping cart
    When I add 1 of "Item 1" to shopping cart
    Then I should see 1 of "Item 1" in the shopping cart
    And I should see $10.00 of "Item 1" in the shopping cart
    And I should see items subtotal of $10.00 in the shopping cart

  @happy_path
  Scenario: Add two different products to shopping cart
    When I add 1 of "Item 1" to shopping cart
    And I add 1 of "Item 2" to shopping cart
    Then I should see 1 of "Item 1" in the shopping cart
    Then I should see 1 of "Item 2" in the shopping cart
    And I should see $10.00 of "Item 1" in the shopping cart
    And I should see $20.00 of "Item 2" in the shopping cart
    And I should see items subtotal of $30.00 in the shopping cart


  Scenario Outline: Add a product to the shopping cart as a previous user
    When I login as "<saved_user>"
    And I add <quantity> of "<item>" to shopping cart
    Then I should see <item_total> of "<item>" in the shopping cart
    And I should see $<item_price> of "<item>" in the shopping cart
    And I should see items subtotal of $<cart_subtotal> in the shopping cart

  @happy_path
  Examples:
    | quantity | item   | item_total | item_price | cart_subtotal | saved_user |
    | 1        | Item 1 | 1          | 10.00      | 10.00         | cust1111   |
    | 1        | Item 1 | 1          | 10.00      | 40.00         | cust_2222  |

  @sad_path
  Examples:
    | quantity | item   | item_total | item_price | cart_subtotal | saved_user |
    | 1        | Item 1 | 1          | 10.00      | 10.00         | cust_empty |

  @bad_path
  Examples:
    | quantity | item   | item_total | item_price | cart_subtotal | saved_user |
    | 1        | Item 1 | 1          | 10.00      | 10.00         | invalid    |

  @happy_path
  Scenario: Add a product to the shopping cart as a previous user
    When I login as "cust111"
    And I add 1 of "Item 1" to shopping cart
    Then I should see 1 of "Item 1" in the shopping cart
    And I should see 1 of "Item 3" in the shopping cart
    And I should see $10.00 of "Item 1" in then shopping cart
    And I should see $30.00 of "Item 3" in the shopping cart
    And I should see items subtotal of $40.00 in the shopping cart

  @happy_path
  Scenario: Add a product to the shopping cart as a previous user with no
  existing products
    When I login as "cust_empty"
    And I add 1 of "Item 1" to shopping cart
    Then I should see 1 of "Item 1" in the shopping cart
    And I should see $10.00 of "Item 1" in the shopping cart
    And I should see items subtotal of $10.00 in the shopping cart
