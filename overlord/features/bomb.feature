Feature: Bomb
  A bomb should be activated by a numeric code.
  A person should be allowed 2 attempts to
    deactivate the bomb.
  A bomb should only be deactivated by the same
  code to activate it.

  Scenario: As a user, I wish to activate the
    bomb
    Given The bomb is not active
    When I submit a valid code "0123"
    Then I should see the bomb is active

  Scenario: As a user, I wish to deactive the
    bomb
    Given The bomb is active with code "0123"
    When I submit a valid code "0123"
    Then I should see the bomb is not active

  Scenario: As a user, I wish to deactive the
    bomb, after a bad guess
    Given The bomb is active with code "0123"
    When I submit the valid code "1111"
    And I submit the valid code "0123"
    Then I should see the bomb is not active

  Scenario: The user fails to deactivate the
    bomb
    Given The bomb is active with code "0123"
    When I submit the valid code "1111"
    And I submit the valid code "1111"
    Then I should see the bomb blow up

