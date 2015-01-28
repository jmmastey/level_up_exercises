Feature: Browse Items
  In order to choose what I want to buy
  As a customer
  I want to be able to browse the items

  Scenario: View All Items
    Given 5 items exist
    When I am on the browse items page
    Then 5 items show on the page

  Scenario: Go to Item
    Given I am on the browse items page
    When I click on an item on the page
    Then I see the item's page