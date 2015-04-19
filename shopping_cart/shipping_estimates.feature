Feature: Shipping Estimates
  In order to check shipping costs
  As a online customer
  I want to give my address and get shipping estimates

#Happy Path
  Scenario: shipping estimate for an item
    Given I have an item in the cart
    When I give valid shipping address
    Then I should see the shipping estimate
    And Total cost should be sum of item cost and shipping estimate

  Scenario: shipping estimates for multiple items
    Given I have multiple items in the cart
    When I give valid shipping address 
    Then I should see shipping estimate for each item 
    And Total cost should be sum of item costs and shipping extimates

#Sad Path
  Scenario: shipping address not in devlivery region
    Given I have an item in the cart
    When I give valid shipping address but not in delivery region
    Then I should see an error that the order cannot be shipped to the address	

#Bad Path
  Scenario: invalid shipping address not supported
    Given I have an item in the cart
    When I give invalid shipping address
    Then I should see an error that the shipping address is invalid