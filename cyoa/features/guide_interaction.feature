Feature: Guide Interaction
  In order to interact with the guide
  As an authenticated user
  I should press the guide button

  Background:
    Given I am an authenticated user

  @happy
  Scenario: Opening the guide
    Given the guide is hidden
    When I press the guide button
    Then the guide becomes unhidden

  @happy
  Scenario: Going to a channel
    Given the guide is open
    When I click the "Travel" channel button
    Then the "Travel" channel starts playing

  @happy
  Scenario: Pressing delete channel
    Given the guide is open
    And I have more than 1 channel
    When I click the "Travel" channel delete button
    Then the delete dialog appears
    And asks if I want to delete the "Travel" channel

  @happy
  Scenario: Deleting a playing channel
    Given the delete dialog is open for the "Travel" channel
    And the "Travel" channel is currently playing
    When I click "Yes"
    Then the "Travel" channel button is removed from the guide
    And the channel is changed

  @happy
  Scenario: Deleting a non-playing channel
    Given the delete dialog is open for the "Travel" channel
    And the "Travel" channel is not currently playing
    When I click "Yes"
    Then the "Travel" channel button is removed from the guide

  @happy
  Scenario: Delete dialog appears correctly
    Given the guide is open
    And I have more than 1 channel
    When I click the "Travel" channel delete button
    Then the delete dialog appears
    And asks if I want to delete the "Travel" channel

  @happy
  Scenario: Create channel dialog appears correctly
    Given the guide is open
    When I click "New Channel"
    Then the new channel dialog appears

  @happy
  Scenario: Creating a channel
    Given the guide is open
    When I click "New Channel"
    And enter a channel name
    And enter a channel tag
    And press OK
    Then a few seconds later a channel should appear in the guide

