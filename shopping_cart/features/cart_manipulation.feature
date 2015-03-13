Feature: Add and remove items from cart
  Once I am logged in
  I want to be able to view and add items to my cart

  Background:
    Given I am logged in

  Scenario: View list of items
    Then I should see the list of items

  Scenario: View item
    Given I am on the "items" page
    When I click on an item
    Then I should be taken to the page for that item

  Scenario: Add item to cart
    Given I am on a page for a particular item
    When I click "+"
    Then a single unit of that item should be added to my cart

  Scenario: Remove item from cart
    Given I am on a page for a particular item
    And that item exists in my cart
    When I click "-"
    Then a single unit of that item should be removed from my cart

  Scenario: Attempt to remove invalid item from my cart
    Given I am on a page for a particular item
    And that item does not exist in my cart
    Then I should not see "-"
