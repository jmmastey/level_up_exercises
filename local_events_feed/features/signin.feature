Feature: Signing in

  Scenario: Welcome to Signin
    Given I visit the welcome page
    Then I see the welcome heading

  Scenario: Successful signin
    Given I visit the signin page
    And I have an account
    When I submit valid signin information
    Then I am on my showings page
    And I see a signout link

  Scenario: Successful signout
    Given I sign in
	When I click on signout
	Then I see the welcome heading

  Scenario: Unsuccessful signin
    Given I visit the signin page
    When I submit invalid signin information
    Then I see the signin page
	And I see an authentication-failure message
