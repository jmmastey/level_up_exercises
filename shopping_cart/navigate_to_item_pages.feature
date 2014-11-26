Feature: Navigate from Shopping Cart to Item Page
  As a customer
  I want to navigate from the shopping cart to an item page
  In order to view more details about the product

  Background
    Given I am on the Shopping Cart page
    And I am logged in

  Scenario: Click on a product that is still carried (Good path)
    Given I have added 1 hammer to my cart
    And a hammer is still carried
    When I click on "hammer"
    Then I should be on the "hammer" page

  Scenario: Click on a product that is no longer carried (Sad path)
    Given I have added 1 screwdriver to my cart
    And a screwdriver is no longer carried
    When I click on "screwdriver"
    Then I should be on the home page
    And should see "We are sorry. That item is no longer carried."
