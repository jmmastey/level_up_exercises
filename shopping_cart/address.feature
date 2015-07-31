Feature:
  As a user
  I want to be able to add my address to display shipping information
  In order to get shipping estimates

  Background:
    Given there is 1 "xBox One" and 1 "WiiU" in the cart
    And the user is on the cart page

  Scenario: Anonymous users without shipping information
    Given the user is not logged in
    And the user has not submitted address information
    Then the cart will not display a shipping estimate

  Scenario: Anonymous users can enter an address
    Given the user is not logged in
    When the user enters address information
    Then the cart will display a shipping estimate

  Scenario: Users can log in for shipping estimates
    Given there is a user account with shipping information
    And the user is not logged in
    When the user logs in
    Then the cart will display a shipping estimate

  Scenario: Users can log in and still need to provide an address for estimates
    Given there is a user account without shipping information
    And the user is not logged in
    When the user logs in
    And the user enters address information
    Then the cart will display a shipping estimate

  Scenario: Users can log in and not have an address or estimate
    Given there is a user account without shipping information
    And the user is not logged in
    When the user logs in
    Then the cart will not display a shipping estimate
