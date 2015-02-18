Feature: Bomb Disarmament

  Background:
    Given A bomb has already been deployed

  Scenario: When I enter the correct code for disarmament
    Given I am on the bomb disarming page
    Then I should see the field "disarming_code" within "row"
    When I fill in the following:
      | disarming_code | 1234 |
      And I click the submit button
    Then I should be on bomb disarmed page

  Scenario: When I enter the incorrect code for disarmament
    Given I am on the bomb disarming page
    Then I should see the field "disarming_code" within "row"
    When I fill in the following:
      | disarming_code | 3333 |
      And I click the submit button
    Then I should not be on bomb disarmed page
  
  Scenario: When I run use up all attempts to disarm it
    Given I am on the bomb disarming page
    Then I should see the field "disarming_code" within "row"
    # Just did it 3 times instead of looping it, eh.
    # The default max attempts is 3 anyway
    When I fill in the following:
      | disarming_code | 3333 |
      And I click the submit button
    When I fill in the following:
      | disarming_code | 3333 |
      And I click the submit button
    When I fill in the following:
      | disarming_code | 3333 |
      And I click the submit button
    Then I should be on bomb detonated page

  Scenario: When the timer runs out before I am able to disarm the bomb
    Given The bomb has a timer set to 5 seconds
      And I am on the bomb disarming page
    Then I should see the field "disarming_code" within "row"
    When The timer runs out
    Then I should be on bomb detonated page
