Feature: Cart reconciliation
  As an online shopper
  I want to add items to the same cart when I am logged out and logged in
  Because I want to easily manage what items I like

  Background:
    Given there are 2 items of the first product in my cart
    And I log out

  Scenario: Losing previous cart upon logout
    Then the cart has no items

  Scenario: Adding items while logged out
    When I am viewing the second product
    And I add 3 items of the second product to my cart
    And I log in
    Then I have 2 items of the first product in my cart
    Then I have 3 items of the second product in my cart

  Scenario: Keeping larger session item amounts
    When I am viewing the first product
    And I add 3 items of the first product to my cart
    And I log in
    Then I have 3 items of the first product in my cart

  Scenario: Keeping smaller session item amounts
    When I am viewing the first product
    And I add 1 item of the first product to my cart
    And I log in
    Then I have 1 item of the first product in my cart
