Feature: Updating items in my cart
  As a customer
  I want to update item quantities in my cart
  So that I can make purchases

  Scenario Outline: I update an item quantity
    Given I have an empty cart
    When I add  "<quantity>" "<item>" to my cart
    And I update quantity of "<item>" to "<update>"
    Then I should see "<total>" "<item>" in my cart
    And I should see the message "<message>"

  @happy
  Examples:
    | quantity | item          | update | total | message |
    | 1        | Sample Item A | 3      | 3     |         |
    | 1        | Sample Item A | -1     | 0     |         |

  @sad
  Examples:
    | quantity | item          | update | total | message |
    | 0        | Sample Item A | 0      | 0     |         |

  @bad
  Examples:
    | quantity | item          | update | total | message                                             |
    | -1       | Sample Item A | 1      | 0     | Select a valid quantity for Sample Item A           |
    | 1        | Sample Item A | -5     | 0     | Select a valid quantity to update for Sample Item A |
    |          | Sample Item A | 1      | 0     | Select a valid quantity for Sample Item A           |
    | 1        | Sample Item A |        | 1     | Select a valid quantity to update for Sample Item A |
