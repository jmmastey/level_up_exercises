Feature: Shopping Cart Items
  In order to see an item's product pages
  As a shopper
  I should be able to click on an item

  Background:
    Given I am viewing "checkout"

  Scenario: Product does not exist
    When I click on "item"
    And "item" does not exist
    Then I should see an error

  Scenario: Product does exist
    When I click on "item"
    And "item" does exist
    Then I am viewing "item page"
