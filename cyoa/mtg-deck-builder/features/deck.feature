Feature: Create/Edit decks
  In order to create the most deadly mtg decks of all time
  As an MTG player
  I should be able to create, and edit my decks

  Background: Log in
    Given I'm logged in
    And there are 10 cards in the database

  Scenario: Create Deck
    And I visit the create deck page
    When I create a deck named "BestDeckEvar"
    Then I expect to have 1 deck named "BestDeckEvar"

  @javascript
  Scenario: Add a card to deck
    And I create a deck
    And I visit the edit deck page
    When I add a card with id 1
    Then I expect to have 1 cards in my deck
      And I expect to have a card with id 1 in my deck

  @javascript
  Scenario: Remove 1 card from deck
    And I create a deck
    And I visit the edit deck page
    And I add a card with id 1
    When I remove a card with id 1
    Then I expect to have 0 cards in my deck

  @javascript
  Scenario: Add different cards to deck
    And I create a deck
    And I visit the edit deck page
    When I add a card with id 1
      And I add a card with id 2
    Then I expect to have 2 cards in my deck
      And I expect to have a card with id 1 in my deck
      And I expect to have a card with id 2 in my deck

  @javascript
  Scenario: Add different cards to deck and remove only one of them
    And I create a deck
    And I visit the edit deck page
    And I add a card with id 1
    And I add a card with id 2
    When I remove a card with id 1
    Then I expect to have 1 cards in my deck
      And I expect to have a card with id 2 in my deck
