#encoding: utf-8

Feature: Happy Shipping Estimates
  In order to get shipping estimates
  As an online shopper
  I should enter my address correctly

  Scenario Outline: Address shipping costs
    Given I'm at the online store
    And I have entered a correct address
    And I have at least 1 item in my shopping cart
    When I try to get a shipping estimate
    And my address is a <address_type>
    Then the estimate should be <cost>

  Examples:
    | address_type  | cost |
    | house         | 50   |
    | apartment     | 100  |
    | business      | 200  |
    