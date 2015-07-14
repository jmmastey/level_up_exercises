#encoding: utf-8

Feature: Visiting an item page
  In order to visit an item page
  As an online shopper
  I should click on an item in my cart

  Scenario: Clicking on an item in my cart
    Given I'm at the online store
    And I have an item in my shopping cart
    When I click on that item
    Then I should be taken to that item's page
    And my cart should be unchanged