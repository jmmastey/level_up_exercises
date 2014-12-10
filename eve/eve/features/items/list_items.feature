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
		Then I see 5 items
	
	Scenario Outline: Listing items
		When I visit the items page
		Then I see <in_game_id> in the EVE ID column
		And I see "<name>" in the name column

		Examples:
			| in_game_id | name             |
			| 34         | Tritanium        |
			| 36         | Mexallon         |
			| 44         | Enriched Uranium |

	Scenario: Navigating to item orders
		When I visit the items page
		And I click the "View orders" link for item #34
		Then I see the orders page
