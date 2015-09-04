Feature: Related Artists
  As a curious Spotify user
  I should see smaller graphs when logged out
  In order to encourage logging in

  Background: I am on the homepage of the website
    Given I am on the homepage

  Scenario Outline: I see the appropriate links
    Then I see a <type> link
      Examples:
      | type      |
      | Sign up   |
      | Login     |

  Scenario: Successful Sign up
    When I sign up with with appropriate credentials
    Then I see a "signed up" confirmation message

  Scenario: Sign up with too short of a password
    When I sign up with a short password
    Then I see an error

  Scenario: Sign up with mismatched passwords
    When I sign up with mismatched passwords
    Then I see an error

  Scenario: Sign up with bad email
    When I sign up with a bad email
    Then I see an error

  Scenario: User forgot their password
    When I use the forgot my password page
    Then I see an email confirmation

  Scenario: User forgot their password AND email
    When I use the forgot my password page with the wrong email
    Then I see an error

  @javascript
  Scenario Outline: Logged out user can't search for depths above (strictly) 2
    Then I see an error popup as soon as I type a depth above <depth>
    Examples:
    | depth |
    | 3     |
    | 4     |
    | 5     |

  Scenario Outline: Logging in
    When I log in
    Then I see a <type> link
      Examples:
      | type         |
      | Edit profile |
      | Logout       |


