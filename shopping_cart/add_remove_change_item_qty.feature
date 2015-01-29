Feature: Add, remove, or change quantities on items in cart
  As a customer
  I want to add, remove, or change quantities on items in my shopping cart
  So that I have the items and quantities I need

  Background:
    Given I am at the shopping cart home page
    And I do not have any items in my shopping cart
    And I am not logged in

  Scenario: Add item to cart
    Given I have added a widget to my cart
    Then I see the widget in my cart
    And the widget's quantity is 1

  Scenario: Add same item twice
    Given I have added a widget to my cart
    And I add another widget to my cart
    Then then cart has 2 widgets

  Scenario: Remove item from cart
    Given I have added a widget to my cart
    And I remove the widget on my cart
    Then I have an empty shopping cart

  Scenario: Change item quantity
    Given I have added a widget to my cart
    When I change the widget quantity to "5"
    Then the cart has 5 widgets

  Scenario: Change item quantity to 0
    Given I have added a widget to my cart
    And I change the widget quantity to "0"
    Then I have an empty shopping cart

  Scenario: Logging in after adding items
    Given I have added a widget to my cart
    And I log in to my account
    And my account already has a widget in its shopping cart
    Then the cart has 2 widgets

  Scenario: Change item quantity to invalid quantity
    Given I have added a widget to my cart
    When I change the quantity to "-2"
    Then I see an "invalid quantity" error
    And the cart has 1 widget