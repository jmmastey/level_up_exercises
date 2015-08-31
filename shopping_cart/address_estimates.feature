Feature: Address Estimates
  As a customer
  I can use my zip code to get shipping estimates
  In order to know how much I'm spending

  Background: I have some items in my cart
    Given: I have some items in my cart

  @Happy
  Scenario Outline: When I input a valid address into the shopping cart, I see the shipping estimate.
    When I put <zip> into the shipping estimator
    Then I should see a shipping cost of <cost>
    Examples:
    | zip      | cost     |
    | "60618"  | "5.00"   |
    | "61534"  | "10.00"  |
    | "33983"  | "20.00"  |

  @Happy
  Scenario: When I input an address within X miles of the store, I see that the shipping could be free.
    When I put 61616 into the shipping estimator
    Then I should see the option to pick up the order from the store

  @Sad
  Scenario Outline: When I put in an invalid zip code, I see an error message
    When I put <bad> into the shipping estimator
    Then I should see an error message
    Examples:
    | bad   |
    | ""    |
    | 1     |
    | 12    |
    | 123   |
    | 2345  |
    | "hi"  |
    | 96598 |

  @Bad
  Scenario Outline: I should not be able to do any injections on the zip field.
    When I put <bad> in to the shipping estimator
    Then I should see an error message
    Examples:
    | bad                               |
    | "; DROP TABLE products;"          |
    | "<script>alert('pwned');</script>"|
    | "alert('pwned');"                 |
