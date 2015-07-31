Feature:
  As a user either logged in or anonmyous
  I want to be able to access an item's page from the shopping cart
  In order to see information about that item

  Background:
    Given a user is on the cart page
    And there is 1 "xBox One" in the cart
    And there is 3 "PS4" in the cart
    And there is 2 "SNES" in the cart

  Scenario Outline: Link to product page
    When the user clicks "<product>" in the cart
    Then the user will be shown the <product> page
    And the product page will show <quantity> <product>'s in cart
  Examples:
    | product  | quantity |
    | xBox One | 1        |
    | PS4      | 3        |
    | SNES     | 2        |

  Scenario Outline: Adding item already in cart
    Given a user is on the <product> page
    When the user clicks "add to cart"
    Then the user sees the "add another" dialog
  Examples:
    | product  |
    | xBox One |
    | PS4      |
    | SNES     |
