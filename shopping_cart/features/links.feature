Feature: item links in cart

  As a customer
  I want to be able to click items in my cart and be taken to their product pages
  So that I can confirm that I have chosen the correct product

  Scenario: click item link
    Given my cart contains an item
    When I click the item
    Then I am taken to the product page for that item
