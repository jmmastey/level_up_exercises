Feature: User Login
  
  Scenario: When User Login is successful
    Given I follow the login link
    Then I should see the user login form
      And I should see a field for my username
      And I should see a field for my password
    When I fill in the username with "svajone"
      And I fill in the password with "svajone69"
      And click on the submit button
    Then I should be on the dashboard page
      And I should see a message thanking me for login in

  Scenario: When User login is not successful
    Given I follow the login link
    Then I should see the user login form
      And I should see a field for my username
      And I should see a field for my password
    When I fill in the username with "svajone"
      And I fill in the password with "svajone"
      And click on the submit button
    Then I should still be on the login page
      And I should see a message telling me either my email/password was incorrect
