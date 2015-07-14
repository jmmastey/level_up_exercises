#encoding: utf-8

Feature: Happy Shipping Estimates
  In order to get shipping estimates
  As an online shopper
  I should enter my address correctly
  And have items in my cart

  Scenario: Address house
    Given I'm at the online store
    And I have entered a correct address
    And I have at least 1 item in my shopping cart
    When I try to get a shipping estimate
    And my address is a house
    Then the estimate should be $50

  Scenario: Address apartment
    Given I'm at the online store
    And I have entered a correct address
    And I have at least 1 item in my shopping cart
    When I try to get a shipping estimate
    And my address is an apartment
    Then the estimate should be $100

  Scenario: Address business
    Given I'm at the online store
    And I have entered a correct address
    And I have at least 1 item in my shopping cart
    When I try to get a shipping estimate
    And my address is an business
    Then the estimate should be $200