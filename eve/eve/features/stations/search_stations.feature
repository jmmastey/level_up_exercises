@station
Feature: Station searching
	As an EVE player
	I want to see a list of stations
	In order to determine what orders I'm looking for

	Background:
		Given I have the following stations:
			| in_game_id | name                                        |
			| 10000      | Jita - Moon IX - Citadel Processing Station |
			| 10001      | Jita - Moon X - Citadel Processing Station  |
			| 10002      | E Nova - Floor 9 - Joe's Office             |
		And I am on the stations page

	Scenario Outline:
		When I search for "<term>"
		Then I see <count> stations
		And I see "<term>" in the search box

		Examples:
			| term                                        | count |
			| jita                                        | 2     |
			| Citadel                                     | 2     |
			| Nova                                        | 1     |
			| Joe                                         | 1     |
			| Dan                                         | 0     |
			| Jita - Moon IX - Citadel Processing Station | 1     |
