@region
Feature: Region searching
	As an EVE player
	I want to see a list of regions
	In order to determine what orders I'm looking for

	Background:
		Given I have the following regions:
			| in_game_id | name        |
			| 1000       | Malpais     |
			| 1001       | The Forge   |
			| 1002       | The Citadel |
			| 1003       | Floor 9     |
			| 1004       | Outer Rim   |
			| 1005       | Inner Rim   |
		And I am on the regions page

	Scenario Outline:
		When I search for "<term>"
		Then I see <count> regions
		And I see "<term>" in the search box

		Examples:
			| term        | count |
			| Joe         | 0     |
			| Forge       | 1     |
			| The Citadel | 1     |
			| Rim         | 2     |
			| or          | 2     |
