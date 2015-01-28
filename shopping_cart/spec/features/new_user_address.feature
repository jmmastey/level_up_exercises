Feature: Unregistered User Address Check
  In order to receive my order
  As an unregistered user
  I want to enter my address

  Background:
    Given I am not logged in
    And I am on the shopping cart page

  @happy
  Scenario: Checkout with items
    Given my cart has 1 item
    When I click the checkout button
    Then I am prompted to register or enter an address