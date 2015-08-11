Feature: Shopping Cart Items
  In order to see an item's product pages
  As a shopper
  I should be able to click on an item

  Background:
    Given I am viewing "checkout"

  Scenario: Product does not exist
    I click on "item"
    Then I am viewing "404"

  Scenario: Product does exist
    I click on "item"
    Then I am viewing "item page"
