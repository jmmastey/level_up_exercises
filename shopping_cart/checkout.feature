Feature: Finalize order
 
  In order to checkout
  As the customer
  I should enter address, payment, and coupon information
 
  Scenario: begin checkout process
    Given I am on the cart page
    When I click the checkout button
    Then I am prompted to enter my address

  Scenario: input an incorrect address
    Given I am on the checkout page
    When I enter my address without a valid zip code
    And I click the Update Address button
    Then I see a message indicating the address was incorrectly entered

  Scenario: input a correct address
    Given I am on the checkout page
    When I enter my valid address
    And I click the Update Address button
    Then I see an estimate for the cost of shipping

  Scenario: enter valid coupon for order
    Given I am on the checkout page
    When I enter a valid coupon code
    And I click the Add Coupon button
    Then I see a message stating that the coupon is invalid

  Scenario: enter invalid coupon for order
    Given I am on the checkout page
    When I enter an invalid coupon code
    And I click the Add Coupon button
    Then I see a message starting that the coupon has been accepted
    And I see that the order total cost has been adjusted

  Scenario: enter a invalid credit card number
    Given I am on the checkout page
    When I enter an invalid credit card number
    Then I see an error stating that the card number was not accepted
  
  Scenario: enter a valid credit card number
    Given I am on the checkout page
    When I enter a valid credit card number
    Then I see an error stating that the card number was accepted

  Scenario: submit order
    Given I correctly entered shipping and billing information
    When I click Submit Order
    Then I see a page stating that the order has been accepted
