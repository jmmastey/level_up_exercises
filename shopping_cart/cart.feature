Feature: A working shopping cart
  As a consumer
  I want a shopping cart
  So that I can manage my ordering

  Scenario: Add item
    Given I am viewing an item
    When I want the item
    Then I should be able to add it to my cart

  Scenario: Remove item
    Given I am viewing my cart
    When I do not want the item
    Then I should be able to remove it from my cart

  Scenario: Update item quantity
    Given I am viewing my cart
    Then I should be able to change the item quantity

  Scenario: View item pages from cart
    Given I am viewing my cart
    Then I should be able to view an item's page

  Scenario: View shipping charges
    Given I am viewing my cart
    Then I should be able to get shipping price by entering my address

  Scenario: Add valid coupon
    Given I am veiwing my cart
    When I enter a valid coupon code
    Then I should see my adjusted subtotal

  Scenario: Add invalid coupon
    Given I am veiwing my cart
    When I enter an invalid coupon code
    Then I should see a message indicating invalid
    And I should not see a change in subtotal

  Scenario: Logging in after anonymous cart not empty
    Given I have added items as an anonymous user
    When I login successfully
    Then I should see my anonymously added items with my previous session items

  Scenario: Adding same SKU to cart
    Given I have added an item
    When I add the same item again
    Then I should see that item with quantity equal to two
