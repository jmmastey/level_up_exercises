Feature: Signing in

  Scenario: Welcome to Signin
    Given a user visits the welcome page
    Then they should see the welcome heading

  Scenario: Successful signin
    Given a user visits the signin page
    And the user has an account
    When they submit valid signin information
    Then they should see their own page
    And they should see a signout link

  Scenario: Successful signout
    Given a signed-in user
	When they click on signout
	Then they should see the welcome heading

  Scenario: Unsuccessful signin
    Given a user visits the signin page
    When they submit invalid signin information
    Then they should see the signin page

  Scenario: User tries to sign in twice
    Given a signed-in user
    And a user visits the signin page
    Then they should see their own page
