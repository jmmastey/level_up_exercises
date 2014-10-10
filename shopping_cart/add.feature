Feature: Add Items to the shopping cart
  In order to build a list of items that I would like to purchase
  As a shopper
  I would like to be able to add items to the shopping cart

  Background:
    Given I have an empty shopping cart
    And "Widget A" costs $1.00
    And "Widget B" costs $10.00
    And "Widget C" costs $100.00

  Scenario Outline: Adding item to cart
    When I add <added_qty> "<item>" to the shopping cart
    Then I should see <expected_qty> items in the shopping cart
    And I should see <expected_qty> "<item>" in the shopping cart
    And I should see "<item>" price $<price_each>
    And I should see "<item>" sub total $<price_total>
    And I should see subtotal price $<price_total>

    @happy_path
    Examples: Happy Path
      | added_qty | item     | expected_qty | price_each | price_total |
      | 1         | Widget A | 1            | 1.00       | 1.00        |
      | 2         | Widget A | 2            | 1.00       | 2.00        |
      | 100       | Widget A | 100          | 1.00       | 100.00      |
      | 1         | Widget B | 1            | 10.00      | 10.00       |
      | 10000     | Widget B | 10000        | 10.00      | 100000.00   |

    @sad_path
    Examples: Sad Path
      | added_qty | item     | expected_qty | price_each | price_total |
      | 0         | Widget A | 0            | 0.00       | 0.00        |

    @bad_path
    Examples: Bad Path
      | added_qty | item     | expected_qty | price_each | price_total |
      | -1        | Widget A | 0            | 0.00       | 0.00        |

  @happy_path
  Scenario: Adding two different items to the shopping cart
    When I add 1 "Widget A" to the shopping cart
    And I add 2 "Widget B" to the shopping cart
    Then I should see 3 items in the shopping cart
    And I should see 1 "Widget A" in the shopping cart
    And I should see 2 "Widget B" in the shopping cart
    And I should see subtotal price $21.00

  @happy_path
  Scenario: Add two of the same items to the shopping cart
    When I add 1 "Widget A" to the shopping cart
    And I add 2 "Widget A" to the shopping cart
    Then I should see 3 items in the shopping cart
    And I should see 3 "Widget A" in the shopping cart
    And I should see subtotal price $3.00

  @happy_path
  Scenario: Add items when authenticated and logout
    When I login as "User A"
    And I add 1 "Widget A" to the shopping cart
    And I add 1 "Widget B" to the shopping cart
    And I logout
    Then I should see 0 items in the shopping cart
    And I should see subtotal price $0.00

  @happy_path
  Scenario: Add items when authenticated and logout and login
    When I login as "User A"
    And I add 1 "Widget A" to the shopping cart
    And I add 1 "Widget B" to the shopping cart
    And I logout
    And I login as "User A"
    Then I should see 2 items in the shopping cart
    And I should see 1 "Widget A" in the shopping cart
    And I should see 1 "Widget B" in the shopping cart
    And I should see subtotal price $11.00

  @happy_path
  Scenario: Merge items from an authenticated and anonymous session
    When I login as "User A"
    And I add 1 "Widget A" to the shopping cart
    And I add 1 "Widget B" to the shopping cart
    And I logout
    And I add 1 "Widget A" to the shopping cart
    And I login as "User A"
    Then I should see 3 items in the shopping cart
    And I should see 2 "Widget A" in the shopping cart
    And I should see 1 "Widget B" in the shopping cart
    And I should see subtotal price $12.00

  @happy_path
  Scenario: Merge different time from an authenticated and anonymous session
    When I login as "User A"
    And I add 1 "Widget A" to the shopping cart
    And I add 1 "Widget B" to the shopping cart
    And I logout
    And I add 1 "Widget C" to the shopping cart
    And I login as "User A"
    Then I should see 3 items in the shopping cart
    And I should see 1 "Widget A" in the shopping cart
    And I should see 1 "Widget B" in the shopping cart
    And I should see 1 "Widget C" in the shopping cart
    And I should see subtotal price $111.00
