Feature: Shipping estimate
  In order to see how much shipping will cost
  As an online shopper
  I want the ability to enter an address and get a shipping estimate

  Scenario: Correct address is entered
    Given the cart contains one or more items
    When a user enters a correct address in the address fields
    Then the cart should display an estimated shipping price

  Scenario: User enters incorrect shipping address
    Given the cart contains one or more items
    When a user enters a bad shipping address
    Then the cart should display a bad address message

  Scenario: No address field displayed when cart is empty
    Given the cart contains zero items
    When a user views the cart page
    Then an address field should not be displayed
