Feature: Manage Quantities Of Shopping Cart Items
  In order to manage items I am about to order
  As a customer
  I want to be a be able to make changes to item selection in the cart

  Scenario: Customer wants to remove all items from the cart should see a warning
    Given Shopping Cart has items
    When I selects the remove all option
    Then I see a warning asking me if i am sure

  Scenario: Customer that wanted to remove all items from the cart and ignores the warning
    Given Shopping Cart has items
    When I selects the remove all option
    And I see a warning asking me if i am sure
    And I ignore the warning and continue
    Then I see that the shopping cart is empty

  Scenario: Customer that wanted to remove all items from the cart changes her mind
    Given Shopping Cart has items
    When I selects the remove all option
    And I see a warning asking me if i am sure
    And I change my mind and do undo the change
    Then I see that the shopping cart content has not changed

  Scenario: Customer that wants to increase the quantity of an item
    Given Shopping Cart has items
    When I selects to increase the quantity of one item
    Then I see that the quantity of the selected item was increased by one

  Scenario: Customer that wants to decrease the quantity of an item
    Given Shopping Cart has items
    When I selects to decrease the quantity of one item
    Then I see that the quantity of the selected item was decreased by one

  Scenario: Customer that wants to decrease the quantity of an item when there is only 1 item in the cart
    Given Shopping Cart has items
    When I selects to decrease the quantity of one item
    Then I see that the shopping cart is empty

  Scenario: Customer that wants to enter new quantity for an item which is greater then zero
    Given Shopping Cart has items
    When I selects enter a new quantity of one item
    Then I see that the quantity of the selected item was modified to the new quantity

  Scenario: Customer that wants to enter new quantity for an item which is zero
    Given Shopping Cart has items
    When I selects enter a new quantity of one item
    Then I see that the item was removed from the cart

  Scenario: Customer that wants to enter new quantity for an item which less than zero
    Given Shopping Cart has items
    When I selects enter a new negative quantity for one item
    Then I should see a warning that the quantity is invalid
    And I should see that the change was reverted

  Scenario: Customer that wants to enter new quantity for an item which is extremely high
    Given Shopping Cart has items
    When I selects enter a new extremely high quantity for one item
    Then I should see a warning that the quantity is invalid
    And I should see that the change was reverted


