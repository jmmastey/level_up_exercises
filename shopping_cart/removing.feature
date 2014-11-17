Feature: Removing items from my cart
  As a customer
  I want to remove item(s) from my cart
  So that I don't have to buy those items

  Background:
    Given I have an empty cart

  Scenario Outline: I remove an item from my empty cart
    When I remove "<quantity>" <item> from my cart
    Then I should see the message "<message>"

  @sad
  Examples:
    | quantity | item          | message           |
    | 0        | Sample Item A | The cart is empty |

  @bad
  Examples:
    | quantity | item          | message                              |
    | 1        | Sample Item A | Item not found in cart               |
    | 1        |               | Select a valid item to remove        |
    |          | Sample Item A | Select a valid quantity for the item |

  Scenario Outline: I remove an item from my cart with items
    When I add "<quantity_1>" "<item_1>" to my cart
    And I add "<quantity_2>" "<item_2>" to my cart
    And I remove "<remove>" "<item_1>" from my cart
    Then I should see "<total>" "<item_1>" in my cart
    And I should see "<quantity_2>" "<item_2>" in my cart
    And I should see "<message>"

  @happy
  Examples:
    | quantity_1 | item_1        | quantity_2 | item_2        | remove | total | message |
    | 1          | Sample Item A | 1          | Sample Item B | 1      | 0     |         |

  @sad
  Examples:
    | quantity_1 | item_1        | quantity_2 | item_2        | remove | total | message |
    | 0          | Sample Item A | 0          | Sample Item B | 0      | 0     |         |

  @bad
  Examples:
    | quantity_1 | item_1        | quantity_2 | item_2        | remove | total | message                                             |
    | 1          | Sample Item A | 1          | Sample Item B | 2      | 0     | Select a valid quantity to remove for Sample Item A |
    | -1         | Sample Item A | 1          | Sample Item B | 1      | 0     | Select a valid quantity for Sample Item A           |
    | 1          | Sample Item A | -1         | Sample Item B | 1      | 0     | Select a valid quantity for Sample Item B           |
    |            | Sample Item A | 1          | Sample Item B | 1      | 0     | Select a valid quantity for Sample Item A           |
    | 1          | Sample Item A |            | Sample Item B | 1      | 0     | Select a valid quantity for Sample Item B           |
    | 1          |               | 1          | Sample Item B | 1      | 0     | Select a valid item to remove                       |
    | 1          | Sample Item A | 1          |               | 1      | 0     | Select a valid item to remove                       |

  Scenario Outline: I remove the same item from my cart twice
    When I add "<quantity>" "<item>" to my cart
    And I remove "<remove_1>" "<item>" from my cart
    And I remove "<remove_2>" "<item>" from my cart
    Then I should "<total>" "<item>" in my cart
    And I should see the message "<message>"

  @happy
  Examples:
    | quantity | item          | remove_1 | remove_2 | total | message |
    | 2        | Sample Item C | 1        | 1        | 0     |         |

  @sad
  Examples:
    | quantity | item          | remove_1 | remove_2 | total | message |
    | 0        | Sample Item C | 0        | 0        | 0     |         |

  @bad
  Examples:
    | quantity | item          | remove_1 | remove_2 | total | message                                   |
    | 2        | Sample Item C | 1        | 1        | 0     | Sample Item C is no longer in cart        |
    |          | Sample Item C | 1        | 1        | 0     | Select a valid quantity for Sample Item C |
    | 2        |               | 1        | 1        | 0     | Select a valid item to remove             |
    | 2        | Sample Item C |          | 1        | 1     | Select a valid quantity for Sample Item C |
    | 2        | Sample Item C | 1        |          | 1     | Select a valid quantity for Sample Item C |
