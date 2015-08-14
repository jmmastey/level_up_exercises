Feature: Manage Cart
  In order to not lose any items
  As a customer
  I want to save my items if I log in or out

  Background:
    Given I am on the shopping cart page

  @happy
  Scenario:
    Given I am not logged in
    And there are items in the cart
    When I log in
    Then I should see all the previous items in my cart
