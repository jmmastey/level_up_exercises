Feature: Ensure users can properly navigate from the shopping cart


  Background:
    Given I have a shopping cart with 10 "Item 1" in it
    Given I have a shopping cart with 2 "Item 2" in it
    Given I have a shopping cart with 5 "Item 3" in it
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $30.00

  Scenario Outline: Navigate back to individual item pages
    When I am on the shopping cart page
    When I click on "<item_name>" in the shopping cart
    Then The item page for "<item_name>" should be displayed

  @happy_path
  Examples: Happy Path
    | item_name |
    | Item 1    |
    | Item 2    |
    | Item 3    |

  @bad_path
  Examples: Navigating to items that don't exist in the shopping cart
    | item_name |
    | Item 999  |
    | O'Neils   |

  Scenario Outline: Navigate to individual item pages after adding item to cart
    Given I have a empty shopping cart
    When I add <quantity> of "<item_name>" to shopping cart
    Then I should see <quantity> of "<item_name>" in shopping cart
    When I click on "<item_name>" in the shopping cart
    Then The item page for "<item_name>" should be displayed

  @happy_path
  Examples: Happy Path
    | quantity | item_name |
    | 1        | Item 1    |
    | 2        | Item 2    |

  @bad_path
  Scenario: Try to navigate to a item page for an item that has been removed
    Given I have a empty shopping cart
    When I add 1 of "Item 1" to shopping cart
    Then I remove "Item 1"
    When I click on "Item 1" in the shopping cart
    Then The item page for "Item 1" should be displayed

