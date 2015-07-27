Feature: Add an item
  In order to buy necessary goods
  As a customer
  I should be able to add items to the cart

  @Happy
  Scenario Outline: When I try to add an item to the cart it should add the item and quantity specified correctly.
    Given I have an empty cart
    And I am on a random item page
    When I try to add <number> of the item to the cart
    Then My cart should have <number> of items
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
  Scenario Outline: When I try to add an item to the cart it should add the item and quantity specified correctly.
    Given I have an empty cart
    And I am on a random item page
    When I try to add <number> of the item to the cart
    Then My cart should have the correct price for <number> of items
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
  Scenario Outline: When I add mutiples of an item to my cart, it should display bulk discounts correctly.
    Given I have an empty cart
    And I am on a random item page
    When I try to add <number> of the item to the cart
    Then My cart should have the correct bulk discount price for <number>
    Examples:
      | number  |
      | 0       |
      | 10      |
      | 20      |
      | 30      |
      | 40      |
      | 50      |
      | 60      |
      | 70      |

  @Happy
  Scenario: When I add new items to the cart, the total cost should update accordingly
    Given I have items in my cart
    And I try to add a random item
    Then I should see my price change accordingly

  @Happy
  Scenario: When I add bundled items to the cart, the bundle should follow correctly
    Given: I have no items in my cart
    And I try to add a bundle deal to my cart
    Then I should have all the items added into my cart

  @Happy
  Scenario: When I add items to the cart, it should verify that the number available does not exceed the number we currently have
    Given I have an empty cart
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
  Scenario: Customer adds item with the same product id to the cart.
    Given I have an cart with one item
    And I view that item
    When I try to add "1" item to the cart
    Then I should have "2" items in my cart

  @Sad
  Scenario: When I try to add an item to the cart that is not in stock, it should show an error
    Given I have an empty cart
    And I am on the page of an item that it not in stock
    When I try to add the item to my cart
    Then I should see an error message

  @Sad
  Scenario: When I try to add an item to the cart that is not in stock, it should not add to the cart
    Given I have an empty cart
    And I am on the page of an item that it not in stock
    When I try to add the item to my cart
    Then I should have "0" items in my cart

  @Sad
  Scenario: When I try to add an item to the cart that is not yet for sale (i.e. not released yet), it should show an error
    Given I have an empty cart
    And I am on the page of an unreleased item
    When I try to add the item to my cart
    Then I should see an error message

  @Sad
  Scenario: When I try to add an item to the cart that is not yet for sale (i.e. not released yet), it shouldn't add to the cart
    Given I have an empty cart
    And I am on the page of an unreleased item
    When I try to add the item to my cart
    Then I should have "0" items in my cart

  @Bad
  Scenario: When I try to add a garbage item to the cart (by messing with the URL or otherwise), it should show an error
    Given I have an empty cart
    And I try to add an invalid item to the cart
    Then I should see an error message

  @Bad
  Scenario: When I try to add a garbage item to the cart (by messing with the URL or otherwise), it should not add to the cart
    Given I have an empty cart
    And I try to add an invalid item to the cart
    Then I should have "0" items in my cart
