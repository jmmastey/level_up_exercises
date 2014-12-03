Feature: Session Management
  As a shopper
  In order to finish previously started shopping sessions
  I want to merge my shopping sessions

  Background:
  Given I am not logged in
    And I have a previous session with following items
      |product|quantity|
      |Item A |3       |
    And Item A has 6 units in stock
    And Item B has 2 units in stock

  @happy
  Scenario: Merge with previous session - item already in the cart
    When I add 3 units of Item A to the cart
      And I log in
    Then I see 6 items of Item A in the cart

  @happy
  Scenario: Merge with previous session - item not in the cart
    When I add 2 units of Item B to the cart
      And logs in
    Then I see 3 items of Item A in the cart
      And I see 2 items of Item B in the cart

  @sad
  Scenario: Merge casues item quantity more than the stock level
    When I add 4 units of Item A to the cart
    Then I see 6 units of Item A in the cart
      And I see exceeds availability error
