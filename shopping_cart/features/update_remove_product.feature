Feature: Update the shopping cart

  Scenario Outline: I update product quantity
    Given I have 1 <product> in shopping cart
    When I change quantity of <product> to <quantity>
    Then the total is <total>
    And quantity is <quantity>

  @happy
  Examples:
    | product      |  quantity   |  price    |  total  |
    | ipad         |  2          |  400      |  800    |
  @sad
  Examples:
    | product      |  quantity   |  price    |  total  |
    | surface      |  1          |  200      |  200    |
  @bad
  Examples:
    | product      |  quantity   |  price    |  total  |
    | iphone       |  -1         |  300      |  0    |

  @happy
  Scenario:
    Given I add "ipad" to cart
    And I add "iphone" to cart

  @happy
  Scenario: Remove product
    When I remove "ipad"
    Then I see only "iphone" in the cart
    And quantity and total gets changed

  @happy
  Scenario: Remove all products from shopping cart
    When I empty shopping cart
    Then I see 0 products in shopping cart
    And I total as 0
