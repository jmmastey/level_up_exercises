Feature: Website shopping cart
  As a consumer
  I want to use a shopping cart
  To make purchases online
  
# Happy path tests
  Scenario: Login to website
    Given I am on the website
    When I enter a valid username
    And I enter a valid password
    Then I should be logged into the website

  Scenario: Add item to empty cart
    Given I am logged in to my account
    And My cart is empty
    When I click "Add to cart" for item X
    Then I should be on the cart page
    And I should see the item X in my cart
    And The quantity field should contain 1

  Scenario: Add duplicate item to cart
    Given I am logged in to my account
    And I have added item X to my cart
    When I click "Add to cart" for item X
    Then The quantity field should contain 2

  Scenario: Delete item from cart
    Given I am logged in to my account
    And I have added item X to my cart
    When I click "Remove" for item X
    Then My cart should be empty

  Scenario: Change quantity for existing item in cart
    Given I am logged in to my account
    And I have added item X to my cart
    When I change the quantity field to a number N greater than 1
    And I click the "Update" button
    Then The quantity field should contain N
    And The order total should be N * (original total)

  Scenario: Add multiple items to cart
    Given I am logged in to my account
    And I have added item X to my cart
    When I add item Y to my cart
    Then I should see both item X and item Y in my cart
    And Both quantity fields should contain 1

  Scenario: Delete single item from cart containing multiple items
    Given I am logged in to my account
    And I have added item X and item Y to my cart
    When I delete item X from my cart
    Then I should see item Y in my cart
    And The quantity field should contain 1

  Scenario: Get shipping estimate
    Given I am logged in to my account
    And I have added item X to my cart
    When I enter valid address information
    And I click "Shipping estimate"
    Then I should see an estimated shipping cost
    And I should see an estimated shipping time

  Scenario: Apply coupon to cart
    Given I am logged in to my account
    And I have added item X to my cart
    When I submit a valid coupon code
    Then I should see a discount applied to my order total

  Scenario: Preserve anonymous cart contents after login
    Given I am not logged in
    And I have added item X to my cart
    When I login to my account
    Then I should see item X in my cart
    And The quantity field should contain 1

  Scenario: Save cart contents on logout
    Given I am logged in to my account
    And I have added item X to my cart
    When I logout
    And I login to my account
    Then I should see item X in my cart
    And The quantity field should contain 1

  Scenario: Merge anonymous cart contents with saved cart contents
    Given I am logged in to my account
    And I have added item X to my cart
    When I logout
    And I add item Y to my anonymous cart
    And I login to my account
    Then I should see item X and item Y in my cart
    And The quantity fields should contain 1

# Sad path tests
  Scenario: Invalid username
    Given I am on the website
    When I enter an invalid username
    Then I should not be logged in
    And I should see an error message

  Scenario: Invalid password
    Given I am on the website
    When I enter a valid username
    And I enter an incorrect password
    Then I should not be logged in
    And I should see an error message

# Bad path tests
  Scenario: Negative quantity
    Given I am logged in to my account
    And I have added item X to my cart
    When I enter an negative value in the quantity field
    And I click the "Update" button
    Then I should see an error message

  Scenario: Too large quantity
    Given I am logged in to my account
    And I have added item X to my cart
    When I enter 1000000 in the quantity field
    And I click the "Update" button
    Then I should see an error message

  Scenario: Apply non-existent coupon to cart
    Given I am logged in to my account
    And I have added item X to my cart
    When I submit a non-existent coupon code
    Then I should see an error message

  Scenario: Apply expired coupon to cart
    Given I am logged in to my account
    And I have added item X to my cart
    When I submit an expired coupon code
    Then I should see an error message

  Scenario: Invalid city in shipping estimate
    Given I am logged in to my account
    And I have added item X to my cart
    When I enter a non-existent city
    And I click "Shipping estimate"
    Then I should see an error message

  Scenario: Invalid state in shipping estimate
    Given I am logged in to my account
    And I have added item X to my cart
    When I enter a non-existent state
    And I click "Shipping estimate"
    Then I should see an error message

  Scenario: Invalid zip code in shipping estimate
    Given I am logged in to my account
    And I have added item X to my cart
    When I enter a non-existent zip code
    And I click "Shipping estimate"
    Then I should see an error message
