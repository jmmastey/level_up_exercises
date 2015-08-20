Feature: TV Interaction
  In order to interact with the tv
  As an authenticated user
  I should press buttons on the tv

  Background:
    Given I am an authenticated user

  @happy
  Scenario: Changing Channel for 1 channel
    Given I only have one channel
    When I press previous channel
    Then I remain on the same channel
    When I press next channel
    Then I remain on the same channel

  @happy
  Scenario: Changing Channel for 2 or more channels
    Given I have more than one channel
    When I press previous channel
    Then I am taken to a different channel
    When I press next channel
    Then I am taken to a different channel

  @happy
  Scenario: Changing Shows at beginning of channel show list
    Given I am at the beginning of a channel show list
    When I press previous show
    Then I remain on the same show
    When I press next show
    Then I am taken to a different show

  @happy
  Scenario: Changing Shows at middle of channel show list
    Given I have three or more shows
    And I am not on the first or the last show
    When I press previous show
    Then I am taken to a different show
    When I press next show
    Then I am taken to a different show

  @happy
  Scenario: Changing Shows at end of channel show list
    Given I am at the end of a channel show list
    When I press previous show
    Then I am taken to a different show
    When I press next show
    Then I remain on the same show

