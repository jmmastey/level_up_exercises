Feature: Address Estimates
  As a customer
  I should be able to see shipping estimates
  In order to know how much I'm spending

  @Happy
  Scenario: When I input a valid address into the shopping cart, we should see a shipping estimate.
    Given I have 5 items in my shopping cart
    When I put 60618 into the shipping estimator
    Then I should see a shipping cost of "$5.00"

  @Happy
  Scenario: When I input an address within X miles of the store, I should see that the shipping could be free.
    Given I have 5 items in my shopping cart
    When I put 61616 into the shipping estimator
    Then I should see the option to pick up the order from the store

  @Sad
  Scenario: When I put in an invalid shipping address, we should see an error message
    Given I have 5 items in my shopping cart
    When I put 6061 into the shipping estimator
    Then I should see an error message

  @Sad
  Scenario: When I put in a shipping address out of the valid shipment zones (outside the US for example), we should see an error message.
    Given I have 5 items in my shopping cart
    When I put 96598 intot he shipping estimator
    Then I should see an error message

  @Bad
  Scenario: The address field should sanitize input
    Given I have 5 items in my shopping cart
    When I put "; DROP TABLE products" in to the shipping estimator
    Then I should see an error message

  @Sad
  Scenario: When I put in a bogus shipping address, we should see an error message
    Given I have 5 items in my shopping cart
    When I put "Hello" into the shipping estimator
    Then I should see an error message