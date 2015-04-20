Feature: Checkout
  As a user
  I want to be able to checkout 
  In order to make a purchase

  Background:
    Given I am on the shopping cart page or on the items page

  Scenario: Checkout with no items in cart
    When I click the checkout button
    And there are no items in my cart
    Then I should be taken to the home page again
    And the page should display "Nothing to checkout"

  Scenario: Checkout with items in cart
    When I click the checkout button
    And there are items in my cart
    Then I should be taken to the checkout page

  Scenario: Enter coupon
    Given I am on the checkout page
    Then I should be given the option to enter a coupon

  Scenario: Enter invalid coupon
    Given I am on the checkout page
    When I enter an invalid coupon
    Then I should be taken to the checkout page
    And the page should display "Invalid coupon"

  Scenario: Enter valid coupon
    Given I am on the checkout page
    When I enter a valid coupon
    Then the discount should be applied on my cart

  Scenario: Enter no coupon
    Given I am on the checkout page
    When I do not enter a coupon
    Then no discount should be applied on my cart

  Scenario: Enter invalid address
    Given I am on the checkout page
    When I enter an invalid address
    Then I should be taken to the checkout page
    And the page should say "Invalid address"

  Scenario: Enter valid address
    Given I am on the checkout page
    When I enter a valid address
    Then I should get the estimated shipping time


