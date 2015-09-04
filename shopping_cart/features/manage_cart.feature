Feature: Manage Cart
  In order to not lose any items
  As a customer
  I want to save my items if I log in or out

  Background:
    Given I am on the shopping cart page

  Scenario: Items in cart are saved if logged out
    Given I am not logged in
    And there are items in the cart
    When I log in
    Then I see all the previous items in my cart
