Feature: Getting Shipping estimates via address
  In order to help judge the items and quanities I want in relation to shipping cost
  As an online shopper
  I want to be ale to enter my address and receive a shipping estimate

  Background:
    Given I have 3 items in my cart
    When I click to get a shipping estimate

  Scenario: Entering valid shipping address
    And I enter a valid shipping address
    Then I should receive a shipping estimate

  Scenario: Autocompletes partial shipping address
    And I enter a partial shipping address
    Then I should recieve an autocompleted partial address warning
    And I should receive a shipping estimate

  Scenario: Warns against invalid shipping address
    And I enter an invalid shipping address
    Then I should recieve an invalid address warning
    And I should not receive a shipping estimate
    