Feature: User can edit profile information
  As a user
  I expect the ability to modify my profile
  When I have logged in

  Background:
    Given there is a user
    And the user is logged in
    And the user is on the profile page

  Scenario: Profile page
    Then the user will see their address information
    And the user will see their name
    And the user will see their obfuscated payment information

  Scenario:
    When the address information is blank
    Then the user will be shown an add address information message

  Scenario:
    Given the address information is blank
    When the user edits their address
    Then address information will be on the profile page

  Scenario:
    Given the user has address information
    When the user edits their address
    Then the new address information will be on the profile page

  Scenario:
    When the user has outdated payment information
    Then the user will be shown an error

  Scenario:
    When the user has outdated payment information
    And the user updates their payment information
    Then the user will be shown a valid payment message

  Senario:
    When the user has valid payment information
    Then the user will be shown a valid payment message
