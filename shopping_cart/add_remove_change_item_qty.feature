Feature: Add, remove, or change quantities on items in cart
  As a customer
  I want to add, remove, or change quantities on items in my shopping cart
  So that I have the quantities and items I need

  Background:
    Given I am at the shopping cart home page with an empty shopping cart
    And I am not logged in as a user

  Scenario: Add item to cart
    When I nagivate to the page for a widget
    And I add the widget to my cart
    Then I see the widget in my cart
    And the widget's quantity is 1

  Scenario: Remove item from cart
    Given I have added a widget to my cart
    And I remove the widget on my cart
    Then I have an empty shopping cart

  Scenario: Remove multiple units from cart
    Given I have added 8 widgets to my cart
    And I change the widget quantity to 3
    Then I the cart has 3 widgets

  Scenario: Change item quantity
    Given I have added a widget to my cart
    When I change the widget quantity to "5"
    Then the cart has 5 widgets

  Scenario: Change item quantity to invalid quantity
    Given I have added a widget to my cart
    When I change the quantity to "@"
    Then I see an "invalid quantity" error
    And the cart has only one widget