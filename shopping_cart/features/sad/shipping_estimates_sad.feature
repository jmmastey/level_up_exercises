#encoding: utf-8

Feature: Sad Shipping Estimates
  In order to get shipping estimates
  As an online shopper
  I should enter my address correctly
  And have items in my cart

  Scenario: No items in cart
    Given I'm at the online store
    And I have entered a correct address
    And I have no items in my shopping cart
    When I try to get a shipping estimate
    Then it should fail
    And tell me I need items to ship first