Feature: Shopping carts
  As an online shopper
  I want to add items to the same cart when I am logged out and logged in
  Because I want to easily manage what items I like

  Background:
    Given I am logged out
    And I have 2 items of product "X" in my cart

  Scenario: Adding items while logged out
    When I am viewing product "Y"
    And I add 3 items to cart
    And I log in
    Then I have 2 item of product "X" in my cart
    Then I have 3 item of product "Y" in my cart

  Scenario: Keeping larger session item amounts
    When I am viewing product "X"
    And I add 3 items to cart
    And I log in
    Then I have 3 item of product "X" in my cart

  Scenario: Keeping smaller session item amounts
    When I am viewing product "X"
    And I add 1 item to cart
    And I log in
    Then I have 1 item of product "X" in my cart

  Scenario: Losing previous cart upon logout
    When I log out
    Then the cart has no items
