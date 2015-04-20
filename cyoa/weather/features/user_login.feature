Feature:
  A a user
  When I visit the home page
  I should be able to log in

  Scenario: Sign up page
    Given I am on the home page
    And I am not logged in
    When I click sign up
    Then I should be taken to the sign up page

  Scenario: Log in
    Given I am on the home page
    And I am not logged in
    When I click log in
    And I enter a valid username
    And I enter a valid password
    And I click the log in button
    Then I should be logged in

  Scenario: Sign up with valid information
    Given I am on the sign up page
    And I enter name as "James"
    And I enter email as "james@weatherman.com"
    And I enter password as "password"
    And I enter password confirmation as "password"
    And I click create my account
    Then I should be taken to the home page with a check your email message

  Scenario: Sign up with invalid information
    Given I am on the sign up page
    And I enter name as ""
    And I enter email as ""
    And I enter password as ""
    And I enter password confirmation as ""
    And I click create my account
    Then I should not be signed up

