Feature: Signing in

  Scenario: Welcome to Signin
    Given a user visits the welcome page
    Then they see the welcome heading

  Scenario: Successful signin
    Given a user visits the signin page
    And the user has an account
    When they submit valid signin information
    Then they see their own page
    And they see a signout link

  Scenario: Successful signout
    Given a signed-in user
	When they click on signout
	Then they see the welcome heading

  Scenario: Unsuccessful signin
    Given a user visits the signin page
    When they submit invalid signin information
    Then they see the signin page
	And they see authentication-failure message

  Scenario: User tries to sign in twice
    Given a signed-in user
    And a user visits the signin page
    Then they see their own page
