Feature: Login
	In order to save my shopping history
  As a user
  I want to login

  Background:
    Given I navigate to the login page

  Scenario Outline: Try logins
    Given user <user> with password <password> <exists>
    When I enter username <user_entry>
    And I enter password <password_entry>
    And I submit the login information
    Then <result>

  @happy
  Examples: Successful logins
    | user | password | exists | user_entry | password_entry | result                                 |
    | john | secret   | exists | john       | secret         | I see the successful login result page |

  @sad
  Examples: Unsuccessful logins
    | user | password | exists         | user_entry | password_entry | result                                 |
    | john | secret   | exists         | john       | wrong          | I see an unsuccessful login message    |
    | john | secret   | exists         | john       | wrong          | I see an unsuccessful login message    |
    | john | secret   | does not exist | john       | secret         | I see an unsuccessful login message    |

  @bad
  Examples: Invalid logins
    | user | password | exists         | user_entry | password_entry | result                                        |
    | john | secret   | exists         |            | wrong          | I see a missing username message              |
    | john | secret   | exists         | john       |                | I see a missing password message              |
    | john | secret   | exists         |            |                | I see a missing username and password message |