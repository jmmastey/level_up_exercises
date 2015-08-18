Feature: Add an item
  As a customer
  I can add items to the cart
  In order to buy necessary goods

  Background:
    Given I have an empty cart

  @Happy
  Scenario Outline: I can add items to the cart and the quantity updates
    When I add <number> items to the cart
    Then My cart has <number> of items
    Examples:
      | number |
      | 0      |
      | 1      |
      | 2      |
      | 3      |
      | 4      |
      | 5      |
      | 6      |
      | 7      |

  @Happy
  Scenario Outline: I can add items to the cart and the price updates
    When I try to add <number> of items to the cart costing "$1.00"
    Then My cart should show the total as <total>
    Examples:
      | number | total |
      | 0      | 0.00  |
      | 1      | 1.00  |
      | 2      | 2.00  |
      | 3      | 3.00  |
      | 4      | 4.00  |
      | 5      | 5.00  |
      | 6      | 6.00  |
      | 7      | 7.00  |

  @Happy
  Scenario Outline: A bulk discount applies for over 10 items.
    When I try to add <number> of an item with bulk discount to the cart
    Then My cart should show the total as <total>
    Examples:
      | number  | total |
      | 0       | 0.00  |
      | 9       | 9.00  |
      | 10      | 9.00  |
      | 20      | 18.00 |
      | 30      | 27.00 |
      | 40      | 36.00 |
      | 50      | 45.00 |

  @Happy
  Scenario: When I add bundled items to the cart, the bundle should follow correctly
    When I try to add a bundle deal to my cart
    Then I should have all the items added into my cart

  @Sad
  Scenario Outline: When I add items to the cart, it should verify that the number available does not exceed the number we currently have
    And I'm on a page for an item we only have <number> of
    When I try to add <quantity> to my cart
    Then I should have <number> of the item in my cart
    Examples:
    | number | quantity |
    | 0      | 1        |
    | 1      | 10       |
    | 2      | 20       |
    | 3      | 30       |
    | 4      | 10       |
    | 5      | 20       |
    | 6      | 30       |
    | 7      | 10       |

  @Happy
  Scenario: I add item with the same product id to the cart.
    And I add an item to my cart
    And I view that item
    When I try to add 1 item to the cart
    Then I should have 1 item in my cart

  @Sad
  Scenario: When I add an item to the cart that is not in stock, it should show an error
    And I am on the page of an item that it not in stock
    When I try to add the item to my cart
    Then I should see an error message

  @Sad
  Scenario: When I add an item to the cart that is not in stock, it should not add to the cart
    And I am on the page of an item that is not in stock
    When I try to add the item to my cart
    Then I should have 0 items in my cart

  @Sad
  Scenario: When I add an item to the cart that is not yet for sale (i.e. not released yet), it should show an error
    And I am on the page of an unreleased item
    When I try to add the item to my cart
    Then I should see an error message

  @Sad
  Scenario: When I add an item to the cart that is not yet for sale (i.e. not released yet), it shouldn't add to the cart
    And I am on the page of an unreleased item
    When I try to add the item to my cart
    Then I should have 0 items in my cart

  @Bad
  Scenario: When I add a garbage item to the cart (by messing with the URL or otherwise), it should show an error
    When I try to add an invalid item to the cart
    Then I should see an error message

  @Bad
  Scenario: When I try to add a garbage item to the cart (by messing with the URL or otherwise), it should not add to the cart
    When I try to add an invalid item to the cart
    Then I should have 0 items in my cart
