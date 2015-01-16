Feature: Login
  In order to save my shopping history
  As a user
  I want to register

  Background:
    Given I navigate to the registration page

  Scenario Outline: Try registrations
    Given user <user> with password <password> <exists>
    When I enter username <user_entry>
    And I enter password <password_entry>
    And I submit the registration information
    Then <result>

  @happy
  Examples: Successful registrations
    | user | password | exists         | user_entry | password_entry | result                                        |
    | john | secret   | does not exist | john       | secret         | I see the successful registration result page |

  @sad
  Examples: Unsuccessful registrations
    | user | password | exists         | user_entry | password_entry | result                              |
    | john | secret   | exists         | john       | secret         | I see a user already exists message |
    | john | secret   | exists         | john       | wrong          | I see a user already exists message |

  @bad
  Examples: Invalid registrations
    | user | password | exists         | user_entry | password_entry | result                                         |
    | john | secret   | does not exist |            | wrong          | I see a missing username message               |
    | john | secret   | does not exist | john       |                | I see a missing password message               |
    | john | secret   | does not exist |            |                | I see a missing username and password message  |
    | john | secret   | exists         |            | wrong          | I see a missing username message               |
    | john | secret   | exists         | john       |                | I see a user already exists message            |
    | john | secret   | exists         |            |                | I see a missing username and password message  |
    | john | secret   | does not exist | 1          | secret         | I see an invalid username message              |
    | john | secret   | does not exist | john       | 1              | I see an invalid password message              |
    | john | secret   | does not exist | 1          | 1              | I see an invalid username and password message |