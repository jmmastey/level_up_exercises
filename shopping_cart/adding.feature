Feature: Adding items to my cart
  As a customer
  I want to add item(s) to my cart
  So that I can make purchases

  Background:
    Given I have an empty cart

  Scenario Outline: I add an item to my empty cart
    When I add "<quantity>" "<item>" to my cart
    Then I should see "<quantity>" "<item>" in my cart
    And I should see "<message>"

  @happy
  Examples:
    | quantity | item          | message |
    | 1        | Sample Item A |         |

  @sad
  Examples:
    | quantity | item          | message |
    | 0        | Sample Item A |         |

  @bad
  Examples:
    | quantity | item          | message                             |
    | -1       | Sample Item A | Sample Item A is not in cart        |
    |          | Sample Item A | Select a quantity for Sample Item A |
    | 1        |               | Select a valid item to add to cart  |

  Scenario Outline: I add an item to my cart with items
    When I add "<quantity_1>" "<item_1>" to my cart
    And I add "<quantity_2>" "<item_2>" to my cart
    Then I should see "<quantity_1>" "<item_1>" in my cart
    And I should see "<quantity_2>" "<item_2>" in my cart
    And I should see "<message>"

  @happy
  Examples:
    | quantity_1 | item_1        | quantity_2 | item_2        | message |
    | 1          | Sample Item A | 1          | Sample Item B |         |

  @sad
  Examples:
    | quantity_1 | item_1        | quantity_2 | item_2        | message |
    | 1          | Sample Item A | 0          | Sample Item B |         |

  @bad
  Examples:
    | quantity_1 | item_1        | quantity_2 | item_2        | message                      |
    | -1         | Sample Item A | 1          | Sample Item B | Sample Item A is not in cart |
    |            | Sample Item A | 1          | Sample Item B | Select a quantity for Sample Item A |
    | 1          | Sample Item A | -1         | Sample Item B | Sample Item B is not in cart |
    | 1          | Sample Item A |            | Sample Item B | Select a quantity for Sample Item B |

  Scenario Outline: I add the same item to my cart twice
    When I add "<quantity_1>" "<item>" to my cart
    And I add "<quantity_2>" "<item>" to my cart
    Then I should see "<total>" "<item>" in my cart
    And I should see "<message>"

  @happy
  Examples:
    | item          | quantity_1 | quantity_2 | total | message |
    | Sample Item B | 1          | 1          | 2     |         |

  @sad
  Examples:
    | item          | quantity_1 | quantity_2 | total | message |
    | Sample Item B | 0          | 0          | 0     |         |

  @bad
  Examples:
    | item          | quantity_1 | quantity_2 | total | message                             |
    | Sample Item B | 1          | -2         | 0     | Invalid quantity for Sample Item B  |
    | Sample Item B | 1          |            | 0     | Select a quantity for Sample Item B |
    | Sample Item B | -2         | 1          | 0     | Invalid quantity for Sample Item B  |
    | Sample Item B |            | 1          | 0     | Select a quantity for Sample Item B |
