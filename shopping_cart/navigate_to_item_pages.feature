Feature: Navigate from Shopping Cart to Item Page
  As a customer
  I want to navigate from the shopping cart to an item page
  In order to view more details about the product

  Background
    Given I am on the Shopping Cart page
    And I am logged in

  Scenario: Click on a product that is still carried (Good path)
    Given I have added a hammer to my cart
    When I click on "hammer"
    Then I should be on the "hammer" page

  Scenario: Click on a product that is no longer carried (Sad path)
    Given I have added a screwdriver to my cart
    When I click on "screwdriver"
    Then I should be on the home page
    And should see "We are sorry. That item is now out of stock."
