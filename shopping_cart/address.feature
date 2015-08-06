Feature: Shipping Estimates from Address
  As a user
  I except the ability to get shipping estimates
  When I have shared my address

  Background:
    Given there is 1 "xBox One" and 1 "WiiU" in the cart
    And the user is on the cart page
    And the user is not logged in

  Scenario: Anonymous users without shipping information
    Given the user has not submitted address information
    Then the cart will not display a shipping estimate

  Scenario: Anonymous users can enter an address
    When the user enters address information
    Then the cart will display a shipping estimate

  Scenario: Users can log in for shipping estimates
    Given there is a user account with shipping information
    When the user logs in
    Then the cart will display a shipping estimate

  Scenario: Users can log in and still need to provide an address for estimates
    Given there is a user account without shipping information
    When the user logs in
    And the user enters address information
    Then the cart will display a shipping estimate

  Scenario: Users can log in and not have an address or estimate
    Given there is a user account without shipping information
    When the user logs in
    Then the cart will not display a shipping estimate
