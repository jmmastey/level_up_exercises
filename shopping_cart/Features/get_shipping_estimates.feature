Feature: Get Shipping Time And Cost Estimates
  In order to make informed decisions regarding shipping
  As a Customer
  I want to have this information available to me as soon as I provide my shipping address

  Scenario:  Customer Enters Valid Shipping Info
    Given I have Items in the cart
    When I Enter my shipping info in the cart
    Then I should see estimated time/cost for the items in the cart

  Scenario:  Customer Enters Invalid Shipping Info
    Given I have Items in the cart
    When I Enter invalid shipping info in the cart
    Then I should see a warning that the shipping info is invalid

