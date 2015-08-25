Feature: New User
  As a user without an account to animetrackr
  I want to be able to create a personal account

  Background:
    Given I do not have an account
    And I visit the sign up page

  Scenario: Create a new account
    When I enter my username
    And I enter my password
    And I enter my confirmation password
    And I enter my email address
    And click sign up
    Then I expect to view my profile page

  Scenario Outline: Username is too short
    When I enter an invalid username, <username>
    And I enter my password
    And I enter my email address
    And click sign up
    Then I expect to have a username is too short error
    And I should not view my profile page
    Examples:
      | username |
      | 1234     |
      | asdf     |
      | _@#$     |

  Scenario Outline: Invalid username
    When I enter an invalid username, <username>
    And I enter my password
    And I enter my email address
    And click sign up
    Then I expect to have a username must contain letters error
    And I should not view my profile page
    Examples:
      | username     |
      | 123456       |
      | 234523452345 |
      | @#$%55@#$%@  |
      | %$@$%        |

  Scenario Outline: Password is too short
    When I enter my username
    And I enter an invalid password, <password>
    And I enter my confirmation password
    And I enter my email address
    And click sign up
    Then I should expect to have a password is too short error
    And I should not view my profile page
    Examples:
      | password |
      | 1234     |
      | 1234567  |
      | asdf123  |
      | asdf     |
      | GFDGF    |
      | !@#$%    |

  Scenario Outline: Invalid password
    Password must be secure and contain certain types of
    characters
    When I enter my username
    And I enter an invalid password, <password>
    And I enter my confirmation password
    And I enter my email address
    And click sign up
    Then I should expect to have an invalid password error
    And I should not view my profile page
    Examples:
      | password   |
      | 123456789  |
      | onlylower  |
      | NoNumbers  |
      | ONLYCAPS   |
      | ASK123FIVE |
      | !$%@#$#@   |

  Scenario Outline: Invalid email
    When I enter my username
    And I enter my password
    And I enter my confirmation password
    And I enter an invalid email, <email>
    And click sign up
    Then I should expect to have an email error
    And I should not view my profile page
    Examples:
      | email              |
      | invalid.com        |
      | invalid@com        |
      | missing@extension  |
      | double@at@sign.com |
      | just_some_text_123 |

  Scenario: Username taken
    When I enter a username that is taken
    And I enter my password
    And I enter my confirmation password
    And I enter my email address
    And click sign up
    Then I should expect to have a username taken error

  Scenario: Email taken
    When I enter an email that is taken
    And I enter my username
    And I enter my password
    And I enter my confirmation password
    And click sign up
    Then I should expect to have an email taken error
