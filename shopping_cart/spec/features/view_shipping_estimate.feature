Feature: View Shipping Estimate
  In order to decide if I want to actually buy from Amazon who has free shipping
  As a customer
  I want to view my shipping estimate

  Background:
    Given I am buying some items
    And I am on the order breakdown page

  @happy
  Scenario: Free Shipping
    When I choose free standard shipping
    Then my grand total is the same
    And I am able to submit my order

  @happy
  Scenario: Overnight Shipping
    When I choose overnight shipping
    Then my grand total increases by the right amount
    And I am able to submit my order

  @sad
  Scenario: Cannot submit without shipping
    When I have not chosen a shipping option
    Then I cannot submit my order