@watch
Feature: New watches
	As a user
	I want to add watches
	In order to look up orders later

	Background:
		Given I have the following items:
			| name                |
			| Tritanium           |
			| Pyerite             |
			| Uranium             |
			| Enriched Uranium    |
			| Kotowskite          |
			| Enriched Kotowskite |
		And I have the following regions:
			| name        |
			| Malpais     |
			| The Citadel |
			| The Forge   |
			| The E Nova  |
		And I have the following stations:
			| name                                      |
			| Ono V - Moon 9 - CBD Corporation Storage  |
			| Ney X - Moon 15 - CBD Corporation Storage |
			| Chicago - Floor 9 - Joe's Office          |

	Scenario: Visiting add page when not logged in
		When I visit the new watch page
		Then I see the message "You need to sign in or sign up before continuing."

	Scenario: Visiting add page when logged in
		Given I am signed in
		When I visit the new watch page
		Then I see the new watch form

	Scenario Outline: Adding a watch
		Given I am signed in
		And I am on the new watch page
		When I set the watch nickname to "<nickname>"
		And I set the watch item to "<item>"
		And I set the watch region to "<region>"
		And I set the watch station to "<station>"
		And I save the watch
		Then I see the message "<message>"

		Examples:
			| nickname       | item             | region      | station                                  | message                                |
			| Test Watch     | Pyerite          |             |                                          | Watch saved successfully               |
			| Test Watch     | Uranium          | Malpais     |                                          | Watch saved successfully               |
			|                | Tritanium        | The Citadel |                                          | Watch saved successfully               |
			| Station Watch  | Kotowskite       |             | Chicago - Floor 9 - Joe's Office         | Watch saved successfully               |
			| Itemless Watch |                  |             |                                          | Item can't be blank                    |
			| Two locations  | Enriched Uranium | The E Nova  | Ono V - Moon 9 - CBD Corporation Storage | Cannot filter by region and by station |
