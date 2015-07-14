#encoding: utf-8

Feature: Bad Shipping Estimates
  In order to get shipping estimates
  As an online shopper
  I should enter my address correctly
  And have items in my cart

  Scenario: Anomalous number of items in cart
    Given I'm at the online store
    And I have entered a correct address
    And I have 100+ items in my shopping cart
    When I try to get a shipping estimate
    Then it should fail
    And tell me to continue on the phone with a representative

  Scenario: Anomalous total of items in cart
    Given I'm at the online store
    And I have entered a correct address
    And I have any number of items in my shopping cart
    And their value is larger than $10000
    When I try to get a shipping estimate
    Then it should fail
    And tell me to continue on the phone with a representative