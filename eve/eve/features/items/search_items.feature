@item
Feature: Item searching
	As an EVE player
	I want to see a list of items
	In order to determine what orders I'm looking for

	Background:
		Given I have the following items:
			| in_game_id | name             |
			| 34         | Tritanium        |
			| 35         | Pyerite          |
			| 4000       | Dinodex          |
			| 4001       | Uranium          |
			| 4002       | Enriched Uranium |
		And I am on the items page

	Scenario Outline:
		When I search for "<term>"
		Then I see <count> items
		And I see "<term>" in the search box

		Examples:
			| term      | count |
			| Joe       | 0     |
			| Tritanium | 1     |
			| pyerite   | 1     |
			| dino      | 1     |
			| uranium   | 2     |
			| it        | 2     |
