Feature: Shipping Estimates
  As a user
  I want to be able to get shipping estimates

  Background:
    Given I view my cart
    And I have products in my cart

  Scenario: Authenticated user with a shipping address
    Given I have a default shipping address
    When I click on the shipping estimate button
    Then I should see an estimate

  Scenario: Authenticated user without a shipping address
    Given I do not have a default shipping address
    When I click on the shipping estimate button
    And enter in my shipping information
    Then I should see an estimate

  Scenario Anonymous user without a shipping address
    Given I am not logged in
    When I click on the shipping estimate button
    And enter in my shipping information
    Then I should see an estimate

  Scenario: Authenticated user with an invalid address
    Given I do not have a default shipping address
    When I click on the shipping estimate button
    And enter in an invalid shipping address
    Then I should not see an estimate
    And I should see an address error