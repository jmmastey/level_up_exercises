Feature: Registered User Address Check
  In order to receive my order
  As a registered user
  I want to enter my address

  Background:
    Given I am logged in
    And I am on the shopping cart page

  @happy
  Scenario: Checkout with new address
    Given I have no saved addresses
    And my cart has 1 item
    When I click the checkout button
    Then I am prompted to add a new address

  @happy
  Scenario: Checkout with existing address
    Given I have a saved address
    And my cart has 1 item
    When I click the checkout button
    Then I am asked to confirm my existing address

  @sad
  Scenario: Checkout with no items
    Given my cart has 0 items
    Then I cannot choose to checkout