Feature: Update Shopping Cart
  In order to get what I want
  As a customer
  I want to be able to change what items are in my cart
  
  Scenario Outline: Add Items
    Given I am <logged_in>
    And I have <number_of_item> "<item_name>" items in my cart
    And I am on the browse items page
    When I click to add the "<item_name>" to my cart
    Then I am on the <result_page> page
    And I have <result_number_of_item> "<item_name>" items in my cart

  @happy
  Examples:
    | logged_in     | number_of_item | item_name | result_page   | result_number_of_item |
    | logged in     | 0              | freezer   | shopping cart | 1                     |
    | logged in     | 1              | freezer   | shopping cart | 2                     |
    | not logged in | 0              | freezer   | shopping cart | 1                     |
    | not logged in | 1              | freezer   | shopping cart | 2                     |

  Scenario Outline: Remove Items
    Given I am <logged_in>
    And I have <number_of_item> "<item_name>" items in my cart
    And I am on the shopping cart page
    When I click to remove the "<item_name>" from my cart
    Then I am on the shopping cart page
    And I have <result_number_of_item> "<item_name>" items in my cart

  @happy
  Examples:
    | logged_in     | number_of_item | item_name | result_number_of_item |
    | logged in     | 3              | freezer   | 0                     |
    | logged in     | 1              | freezer   | 0                     |
    | not logged in | 3              | freezer   | 0                     |
    | not logged in | 1              | freezer   | 0                     |

  Scenario Outline: Update Item Quantity
    Given I am <logged_in>
    And I have <number_of_item> "<item_name>" items in my cart
    And I am on the shopping cart page
    When I click edit item quantity
    And I change the quantity to <new_quantity> for item "<item_name>"
    And I click save item quantity
    Then I am on the <result_page> page
    And I see <message>
    And I have <result_number_of_item> "<item_name>" items in my cart

  @happy
  Examples: Successful updates
    | logged_in     | number_of_item | new_quantity | item_name | result_page   | message                                             | result_number_of_item |
    | logged in     | 3              | 2            | freezer   | shopping cart | no specific message                                 | 2                     |
    | logged in     | 1              | 3            | freezer   | shopping cart | no specific message                                 | 3                     |
    | not logged in | 3              | 2            | freezer   | shopping cart | no specific message                                 | 2                     |
    | not logged in | 1              | 3            | freezer   | shopping cart | no specific message                                 | 3                     |

  @bad
  Examples: Unsuccessful updates
    | logged in     | 2              | 0            | freezer   | shopping cart | the message "click remove to remove item from cart" | 2                     |
    | not logged in | 2              | 0            | freezer   | shopping cart | the message "click remove to remove item from cart" | 2                     |
    | logged in     | 2              | -1           | freezer   | shopping cart | the message "invalid quantity"                      | 2                     |
    | not logged in | 2              | a            | freezer   | shopping cart | the message "invalid quantity"                      | 2                     |