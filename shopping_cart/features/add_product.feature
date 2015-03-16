Feature: Adding product to shopping cart

  Scenario Outline: I add a product in shopping cart
    Given I have empty shopping cart
    When I add <product> in shopping cart
    Then I see <quantity> and <price> and <total>

  @happy
  Examples:
    | product      |  quantity   |  price    |  total  |
    | ipad         |  2          |  400      |  800    |
    | iphone       |  1          |  300      |  300    |

  @bad
  Examples:
    | product        | quantity   | price    | total |
    | watch          | 0          | 400      | 0     |

  @bad
  Scenario: Adding product with no availability
    Given I have empty shopping cart
    When I add "watch" to shopping cart
    Then I see 0 "watch" in shopping cart

  @happy
  Scenario: Adding same product twice in cart
    Given I have empty shopping cart
    When I add "ipad" to shopping cart twice
    Then I see 1 "ipad" but quantity is 2

  @happy
  Scenario: Adding two different products to shopping cart
    When I add 1 "ipad" to shopping cart
    And 1 "iphone" to shopping cart
    Then I see total 2 products in shopping cart
    And I see quantity price and total

  @happy
  Scenario: Adding products as anonymous user and log in to account
    Given I am not login in to my account
    When  I add "ipad" to shopping cart
    And after adding product I login
    Then I see the "ipad" in my shopping cart

  @happy
  Scenario: Adding products as an existing user and log out
    Given I login as existing user
    When I add 1 "ipad" to shopping cart
    And I log out
    Then I see empty shopping cart

  @happy
  Scenario: Adding products as an existing user and log out and login
    Given I login as existing user
    When I add 1 "iphone" to shopping cart
    And I log out
    And I log in
    Then I see 1 total products in the shopping cart
    And I see "iphone" with total and quantity in shopping cart