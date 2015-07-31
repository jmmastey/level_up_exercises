Feature:
  As a user either logged in or anonymous
  I want to be able to add, remove, and change the quantity of items in the cart
  So that I can ultimatly have control over what I order.

  Background:
    Given a user is on the home page
    And the user is EITHER logged in OR anonymous

  Scenario Outline: Add item to the cart
    Given the user opens the product page for <product>
    When the user adds the item to the cart
    Then the cart will have 1 item in it
    And the user will see the cart page
  Examples:
    | product  |
    | xBox One |
    | PS4      |
    | WiiU     |
    | SNES     |

  Scenario Outline: Remove item from the cart
    Given there is 1 <product> in the cart
    And the user is on the cart page
    When the user removes <product> from the cart
    Then the cart will have 0 items in it
  Examples:
    | product  |
    | xBox One |
    | PS4      |
    | WiiU     |
    | SNES     |

  Scenario Outline: Remove item from cart without removing all items
    Given there is <xBox #> "xBox One" in the cart
    And there is <PS4 #> "PS4" in the cart
    And the user is on the cart page
    And the cart has <Total> items in it
    When the user removes PS4 from the cart
    Then the cart will have <xBox #> item in it
  Examples:
    | xBox # | PS4 # | Total |
    | 1      | 2     | 3     |
    | 10     | 2     | 12    |
    | 1      | 1     | 2     |
    | 1111   | 2222  | 3333  |

  Scenario Outline: Change cart items quantity
    Given there is <xBox #> "xBox One" in the cart
    And there is <PS4 #> "PS4" in the cart
    And the user is on the cart page
    And the cart has <Total> items in it
    When the user changes the quantity of "xBox One" to <xBox New>
    Then the cart will have <Final> items in it
  Examples:
    | xBox # | PS4 # | Total | xBox New | Final |
    | 1      | 2     | 3     | 2        | 4     |
    | 10     | 2     | 12    | 15       | 17    |
    | 1      | 1     | 2     | 6        | 7     |
    | 1111   | 2222  | 3333  | 2        | 2224  |

  Scenario Outline: Changing the item quantity to zero removes it
    Given there is <quantity> "WiiU" in the cart
    And the user is on the cart page
    When the user changes the quantity of "WiiU" to 0
    Then the cart will have 0 items in it
    And the user will see a "WiiU" "removed from cart" message
  Examples:
    | quantity |
    | 15       |
    | 1        |
    | 3        |
