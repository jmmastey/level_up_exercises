Feature: View and manipulate cart
  Once I am logged in
  I should be able to manipulate my cart

  Background:
    Given I am logged in

  Scenario: View cart with items
    When I click on the shopping cart icon
    And my cart has more than one item
    Then I should see the list and quantity of those items

  Scenario: view cart with no items
    When I click on the shopping cart icon
    And my cart has no items
    Then I should see no items on my page

  Scenario: Remove items from cart
    Given I am on the shopping cart page
    When I click "-" next to am item
    Then a single unit of that item should be removed from my cart

  Scenario: Item disappears from cart
    Given I am on the shopping cart page
    And there is a single unit of one item in my cart
    When I click "-"
    Then that item should vanish from my cart

  Scenario: Increase quantity of item in cart
    Given I am on the shopping cart page
    And there is an item on that page
    When I click "+" next to that item
    Then a single unit of that item should be added to my cart

  
