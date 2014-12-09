Feature: List items
	As an EVE player
	I want to list items
	In order to see their orders

	Background:
		Given I have the following items:
			| in_game_id | name             |
			| 34         | Tritanium        |
			| 35         | Pyerite          |
			| 36         | Mexallon         |
			| 37         | Isogen           |
			| 44         | Enriched Uranium |

	Scenario: Counting items
		When I visit the items page
		Then I should see 5 items
	
	Scenario Outline: Listing items
		When I visit the items page
		Then I should see <in_game_id> in the EVE ID column
		And I should see "<name>" in the name column

		Examples:
			| in_game_id | name             |
			| 34         | Tritanium        |
			| 35         | Pyerite          |
			| 36         | Mexallon         |
			| 37         | Isogen           |
			| 44         | Enriched Uranium |
