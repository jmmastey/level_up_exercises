#encoding: utf-8

Feature: Bad Shipping Estimates
  In order to get shipping estimates
  As an online shopper
  I should enter my address correctly

  @bad
  Scenario: Anomalous number of items in cart
    Given I'm at the online store
    And I have entered a correct address
    And I have 100+ items in my shopping cart
    When I try to get a shipping estimate
    Then an overloaded cart error message should appear
    And tell me to continue on the phone with a representative

  @bad
  Scenario: Anomalous total of items in cart
    Given I'm at the online store
    And I have entered a correct address
    And I have any number of items in my shopping cart
    And their value is larger than $10000
    When I try to get a shipping estimate
    Then a costly cart error message should appear
    And tell me to continue on the phone with a representative

  @happy
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
    
  @bad
  Scenario: No items in cart
    Given I'm at the online store
    And I have entered a correct address
    And I have no items in my shopping cart
    When I try to get a shipping estimate
    Then an empty cart error message should appear
    And tell me I need items to ship first
