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

  @javascript
  Scenario: Search for cards that have two types
    And there is a card with types "creature,artifact" in the database
    When I visit the card search page
      And I search for cards with type "creature"
      And I search for cards with type "artifact"
    Then I should see at least 1 cards with the type "creature"
      And I should see at least 1 cards with the type "artifact"

  @javascript
  Scenario: Search for cards by text
    And there is a card with "flying"
    When I visit the card search page
      And I search for cards with "flying"
    Then I should see at least 1 cards with "flying"

  @javascript
  Scenario: Search for cards by multiple text keywords
    And there is a card with "flying, deathtouch"
    When I visit the card search page
      And I search for cards with "flying"
      And I search for cards with "deathtouch"
    Then I should see at least 1 cards with "flying, deathtouch"

  @javascript
  Scenario: Search by card color
    And there is a card with colors "blue"
    When I visit the card search page
      And I search for cards with color "blue"
    Then I should see at least 1 cards with color "blue"
