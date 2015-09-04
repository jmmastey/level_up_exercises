Feature: Logged in Operations
  As a curious Spotify user
  I should be able to see larger graphs when logged in
  In order to get more information about relationships between artists

  Background: I am logged in
    Given I have logged on to the website

  Scenario Outline: I see the appropriate links
    Then I see a <type> link
      Examples:
      | type         |
      | Edit profile |
      | Logout       |

  Scenario: Successful email change
    When I change my email to another valid email
    Then I see a "account has been updated" confirmation message

  Scenario: Failed email change
    When I change my email to something invalid
    Then I see an error

  Scenario: Successful password change
    When I change my password to a valid new password
    Then I see a "account has been updated"  confirmation message

  Scenario: Unsuccessful password change (too short)
    When I change my password to something too short
    Then I see an error

  Scenario: Unsuccessful password change (don't match)
    When I change my password but the passwords don't match
    Then I see an error

  @javascript
  Scenario Outline: Logged in user can't search for depths above (strictly) 5
    Then I see an error popup as soon as I type a depth above <depth>
    Examples:
      | depth |
      | 6     |
      | 7     |
      | 8     |

  Scenario Outline: Logging out
    When I log out
    Then I see a <type> link
      Examples:
      | type      |
      | Sign up   |
      | Login     |

  @slow
  @javascript
  Scenario: Logged in user should be able to search for depths above 2
    When I search for Black Sabbath at a depth 3
    Then I see a graph