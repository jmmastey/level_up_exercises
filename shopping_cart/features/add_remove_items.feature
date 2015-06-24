Feature: add/remove and change quantities of items on shopping cart
  As a shopper I want to be able to change the  items in my shopping cart
  so I can get the exact order I want

  Scenario: Adding an item to a Shopping Cart
    Given I am on the shopping cart page
    When I add an iphone to my shopping cart
    Then I should see an iphone in my shopping cart



  Scenario Outline: Adding multiple items to Shopping Cart
    Given I am on the shopping cart page
    When I add <number> different itemss in my shopping cart
    Then I should see the same <number> different items in my shopping cart

    Examples:
      | number |
      |   2    |
      |   3    |
      |   4    |
      |   5    |


  Scenario: Adding an item with a quantity of 0 to a Shopping Cart
    Given I am on the shopping cart page
    When I change the quantity of an iphone to 0
    And  attempt to add the iphone to my shopping cart
    Then I should receive an error message


  Scenario Outline: Adding an item with different quantities to Shopping Cart
    Given I am on the shopping cart page
    When I  add <quantity> mac(s to my shopping cart
    Then I should see <quantity> macs in my shopping cart

     Examples:
      | quantity |
      |   2      |
      |   3      |
      |   4      |
      |   5      |


  Scenario: Removing an item in a Shopping Cart
    Given I am on the shopping cart page
    And have 5 different items
    When I remove a flat screen tv
    Then I should no longer see that flat screen in my shopping cart


  Scenario Outline:Removing Items in Shopping Cart
    Given I am on the shopping cart page
    And I have 20 different items
    When I remove  <number> different items(s) in my shopping cart
    Then I no longer see those <number> different item(s) in my shopping cart that I removed

    Examples:
      | number |
      |   2    |
      |   3    |
      |   4    |
      |   5    |


  Scenario : Removing more Items than in Shopping Cart
    Given I am on the shopping cart page
    And I have 20 different items
    When I attempt to remove 21 different items(s) in my shopping cart
    Then I should see an error message



  Scenario Outline:Editing Items in Shopping Cart
    Given I am on the shopping cart page
    And have an ipod with a quantity of 20
    When I change the quantity to <number> ipods in my shopping cart
    Then I should see  <number> ipods in my shopping cart

    Examples:
      | number |
      |   5    |
      |   13   |
      |   2    |
      |   6    |
