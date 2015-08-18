Feature: Remove an Item
  As a customer
  I should be able to remove items from the cart
  In order to buy exactly what I want
  @Happy
  Scenario: Items remove from the cart correctly.
    Given I have 5 items in my cart.
    When I try to remove one of those items
    Then It is no longer be in my cart

  @Happy
  Scenario: When I try to remove multiple items from the cart, they all remove correctly.
    Given I have <items> distinct items in my shopping cart
    When I remove the first <number>
    Then I have <total> items in my shopping cart
    Examples:
    | items | number | total |
    |  10   |  10    |  0    |
    |  10   |  5     |  5    |
    |  10   |  4     |  6    |
    |  10   |  3     |  7    |
    |  10   |  2     |  8    |
    |  10   |  1     |  9    |

  @Sad
  Scenario: When I remove something not in the cart, I can see an error
    Given I have 5 items in my cart
    When I try to remove an item that is not in the cart
    Then I see an error message

  @Sad
  Scenario: Item quantities should not reach below 0.
    Given I have 5 items in my cart
    And I have adjusted the quantity of one item to zero
    When I try to remove that item from my cart
    Then I don't have that item in my cart

  @Sad
  Scenario: When I remove something from the cart which is not yet released, I see an error message.
    Given I have 5 items in my cart
    When I try to remove an item that is not yet for sale
    Then I see an error message

  @Bad
  Scenario: When I try to remove something that is not a product, I see an error message
    Given I have 5 items in my cart
    When I try to remove something that is not a product
    Then I see an error message