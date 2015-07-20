Feature:
  As a user I want to be able to add my address to display shipping information

  Background:
    Given there is 1 "xBox One" and 1 "WiiU" in the cart
    And the user is on the cart page
    And no shipping estimates are displayed

  Scenario: Anonymous users can enter an address
    Given the user is not logged in
    When the user enters address information
    Then the cart will display a shipping estimate

  Scenario: Users can log in for shipping estimates
    Given the user is not logged in
    When the user logs in
    And the user has address information
    Then the cart will display a shipping estimate

  Scenario: Users can log and still need to provide an address
    Given the user is not logged in
    When the user logs in
    And the user does not have address information
    And the user enters address information
    Then the cart will display a shipping estimate
