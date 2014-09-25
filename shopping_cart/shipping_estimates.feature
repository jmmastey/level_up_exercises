Feature: Shipping Estimates
  In order to purchase items online
  As an online shopper
  I want to be receive shipping estimates on my order

  Background: My cart already contains some items
    Given my cart contains 3 pairs of socks
    And my cart contains 1 pair of jeans
    And I'm on the shopping cart page

  Scenario: Valid zip code entry
    When I enter "48105" into the "zip-code" field
    And I press "Estimate my shipping"
    Then I should see an estimate for "Overnight delivery"
    And I should see an estimate for "2Day Express"
    And I should see an estimate for "Ground delivery"

  Scenario: Invlaid zip code entry
    When I enter "words" into the "zip-code" field
    And I press "Estimate my shipping"
    Then I should see the message "Please enter a valid zip code."

  Scenario: No items in cart
    Given I remove all the items in my cart
    When I enter "48105" into the "zip-code" field
    And I press "Estimate my shipping"
    Then I should see the message "You must have items in the cart to receive a shipping estimate"