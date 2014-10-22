Feature: Add Products to shopping cart
  To create a list of products i would like to buy
  As a consumer
  I need to be able to add these products into a shopping cart

  Background:
    Given an empty shopping cart
    And "Product 1" which costs $5.00
    And "Product 2" which costs $20.00
    And "Product 3" which costs $29.99

  Scenario Outline: Adding a product to shopping cart
    When I add <add_quantity> of "<product>" to shopping cart
    Then I should see <expected_total> products in shopping cart
    And I should see <resulting_quantity> of "<product>" in shoppting cart
    And I should see "<product>" price $<product_price_individual>
    And I should see "<product>" sub total $<product_price_sub_total>

    @happy_path
    Examples: Happy Path
    | add_quantity  | product   | expected_total  | product_price_individual  | product_price_sub_total|
    | 1             | Product 1 | 1               | 5.00                      | 5.00                   |
    | 2             | Product 1 | 2               | 5.00                      | 10.00                  |
    | 3             | Product 1 | 3               | 5.00                      | 15.00                  |
    | 4             | Product 1 | 4               | 5.00                      | 20.00                  |
    | 1             | Product 2 | 1               | 20.00                     | 20.00                  |
    | 1             | Product 2 | 2               | 20.00                     | 40.00                  |
    | 1             | Product 2 | 3               | 20.00                     | 60.00                  |
    | 1             | Product 3 | 1               | 29.99                     | 29.99                  |
    | 1             | Product 3 | 50              | 29.99                     | 1499.50                |

    @sad_path
    Examples: Sad Path
    | add_quantity  | product   | expected_total  | product_price_individual  | product_price_sub_total|
    | 0             | Product 1 | 1               | 0.00                      | 0.00                   |
    | 0             | Product 2 | 1               | 0.00                      | 0.00                   |
    | 0             | Product 3 | 1               | 0.00                      | 0.00                   |

    @bad_path
    Examples: Bath Path
    | add_quantity  | product   | expected_total  | product_price_individual  | product_price_sub_total|
    | 1             | Product 1 | 1               | 5.00                      | 5.00                   |


  @happy_path
  Scenario: Adding two different products to shopping cart
    When I add 1 "Product 1" to shopping cart
    And I add 1 "Product 2" to shopping cart
    Then I should see 2 total products in the shopping cart
    And I should see 1 "Product 1" in shopping cart
    And I should see 1 "Product 2" in shopping cart
    And I should see a subtotal price of $25.00

  @happy_path
  Scenario: Adding two of the same products to shopping cart
    When I add 1 "Product 2" to shopping cart
    And I add 4 "Product 2" to shopping cart
    Then I should see 5 total products in the shopping cart
    And I should see 5 "Product 2" in shopping cart
    And I should see a subtotal price of $100.00

  @happy_path
  Scenario: Adding products as annonymous user
    When I add 1 "Product 3" to shopping cart
    Then I should see 1 total products in the shopping cart
    And I should see 1 "Product 2" in shopping cart
    And I should see a subtotal price of $29.99

  @happy_path
  Scenario: Adding products as annonymous user then login in
    When I add 1 "Product 3" to shopping cart
    And I login
    Then I should see 1 total products in the shopping cart
    And I should see 1 "Product 2" in shopping cart
    And I should see a subtotal price of $29.99

  @happy_path
  Scenario: Adding products as an existing user
    When I login as existing user
    And I add 1 "Product 1" to shopping cart
    Then I should see 1 total products in the shopping cart
    And I should see 1 "Product 1" in shopping cart
    And I should see a subtotal price of $5.00

  @happy_path
  Scenario: Adding products as an existing user and log out
    When I login as existing user
    And I add 1 "Product 1" to shopping cart
    And I log out
    Then I should see 0 total products in the shopping cart
    And I should see a subtotal price of $0.00

  @happy_path
  Scenario: Adding products as an existing user and log out and login
    When I login as existing user
    And I add 1 "Product 1" to shopping cart
    And I log out
    And I log in
    Then I should see 1 total products in the shopping cart
    And I should see 1 "Product 1" in shopping cart
    And I should see a subtotal price of $5.00


