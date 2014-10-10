Feature: Navigate within shopping cart
  In order to interact with items in the shopping cart
  As a shopper
  I would like to be able to navigate to item page directly from the shopping cart

  Background:
    Given the shopping cart contains 1 "Widget A"
    And the shopping cart contains 2 "Widget B"
    And I am viewing the shopping cart

  @happy_path
  Scenario: Click the link for a widget
    When I click on "Widget A"
    Then I should see "Widget A" product page
    And I should not see "Widget B"

  @happy_path
  Scenario: Click the link for a different product
    When I click on "Widget B"
    Then I should see "Widget B" product page
    And I should not see "Widget A"
