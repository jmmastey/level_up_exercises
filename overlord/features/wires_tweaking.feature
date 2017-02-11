Feature: Playing with the wires

	Tweaking with the wires, you get to disarm or trigger the bomb.

	Scenario: The bomb is disarmed.
	Given I cut the right wire

	Scenario: The bomb is triggered
	Given I cut any other wire but the right one.