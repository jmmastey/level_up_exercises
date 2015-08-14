Feature: Search cards
  In order to efficiently build deadly MTG decks
  As an MTG player
  I should be able to search, filter, and sort cards

  Background: Log in
    Given I'm logged in

  @javascript
  Scenario: Search for cards by name
    And there is a card named "OMG SO OP!" in the database
    When I visit the card search page
      And I search for the card named "OMG SO OP!"
    Then I should see the card named "OMG SO OP!"

  @javascript
  Scenario: Search for cards by type
    And there is a card with type "creature" in the database
    When I visit the card search page
      And I search for cards with type "creature"
    Then I should see at least 1 cards with the type "creature"
