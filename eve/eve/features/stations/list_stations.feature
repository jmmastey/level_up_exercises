@station
Feature: Listing stations
	As an EVE player
	I want to list stations
	In order to find a location to filter orders against

	Scenario: No stations
		When I visit the stations page
		Then I see the message "Could not find any stations."

	Scenario Outline: Listing stations
		Given a station exists with in-game ID <in_game_id> and name <name>
		When I visit the stations page
		Then I see <in_game_id> in the EVE ID column
		And I see "<name>" in the name column

		Examples:
			| in_game_id | name       |
			| 1          | Deep Core  |
			| 2          | Inner Rim  |
			| 3          | Outer Rim  |
			| 4          | Outest Rim |
