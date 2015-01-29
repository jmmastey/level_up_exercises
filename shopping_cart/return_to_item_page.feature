Feature: Return to item page for items in cart
  As a customer
  I want to go to the product page for items in my cart
  So that I can view details for the item

  Background:
    Given I am at the shopping cart home page
    And I have a widget in my shopping cart
    
  Scenario:
    When I click on the widget line item
    Then I am taken to the product page for widgets