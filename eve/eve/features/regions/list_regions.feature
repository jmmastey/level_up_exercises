@region
Feature: Listing regions
	As an EVE player
	I want to list regions
	In order to find a location to filter orders against

	Scenario: No regions
		When I visit the regions page
		Then I see the message "Could not find any regions."

	Scenario Outline: Listing regions
		Given a region exists with in-game ID <in_game_id> and name <name>
		When I visit the regions page
		Then I see <in_game_id> in the EVE ID column
		And I see "<name>" in the name column

		Examples:
			| in_game_id | name       |
			| 1          | Deep Core  |
			| 2          | Inner Rim  |
			| 3          | Outer Rim  |
			| 4          | Outest Rim |
