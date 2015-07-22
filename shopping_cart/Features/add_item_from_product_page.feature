Feature: Add an Item from the product page
  In order to add an item from the product page
  As a Customer
  I want to select an item and add to the cart

  Scenario: Customer is logged in and wants to add a first item to the cart
    Given There are no items in the cart
    And I am on an item page
    And I am logged in
    When I operate the add the item control
    Then I should see that the item was added to the cart
    And I should stay on the item page

  Scenario: Customer is logged in and wants to add another item to the cart
    Given There are items in the cart
    And I am on an item page
    And I am logged in
    When I operate the add the item control
    Then I should see that the item was added to the cart
    And I should stay on the item page

  Scenario: Customer is logged in and wants to add another item with the same sku to the cart
    Given There are items in the cart
    And I am on an item page
    And I am logged in
    When I operate the add the item control with an existing sku
    Then I should see that the item was added to the cart
    And I should stay on the item page


  Scenario: Customer is not logged in and wants to add a first item to the cart
    Given There are no items in the cart
    And I am on an item page
    And I am not logged in
    When I operate the add item control
    Then I should be prompted to login
    And I should see that the item was added to the cart
    And I should stay on the item page

  Scenario: Customer is not logged in and wants to add a first item to the cart but does not want to log in
    Given There are no items in the cart
    And I am on an item page
    And I am not logged in
    When I operate the add item control
    Then I should be prompted to login
    And I should see that the item was added to the cart
    And I should stay on the item page

