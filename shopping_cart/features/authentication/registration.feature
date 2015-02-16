Feature: Registration

  Scenario: Registration is successful
    Given I follow the registration link
    Then I should see the registration form
      And I should see a field for my username
      And I should see a field for my password
      And I should see a field for my password confirmation
      And I should see a field for my email
    When I fill in the username with "svajone"
      And I fill in the password with "svajone69"
      And I fill in the password confirmation with "svajone69"
      And I fill in the email with "svajone@svajone.lt"
      And click on the submit button
    Then I should be on the dashboard page
      And I should see a message thanking me for registering

  Scenario: Registration has missing require fields
    Given I follow the registration link
    Then I should see the registration form
      And I should see a field for my username
      And I should see a field for my password
      And I should see a field for my password confirmation
      And I should see a field for my email
    When I fill in the username with "svajone"
      And I fill in the password with "svajone69"
      And I fill in the password confirmation with "svajone69"
      And click on the submit button
    Then I should still be on the registration page
      And I should see a message telling me to fill in the email

  Scenario: Registration has bad data
    Given I follow the registration link
    Then I should see the registration form
      And I should see a field for my username
      And I should see a field for my password
      And I should see a field for my password confirmation
      And I should see a field for my email
    When I fill in the username with "svajone"
      And I fill in the password with "svajone69"
      And I fill in the password confirmation with "svajone69"
      And I fill in the email with "svajone@@@svajone.lt"
      And click on the submit button
    Then I should still be on the registration page
      And I should see a message telling me that the email I entered is not valid
