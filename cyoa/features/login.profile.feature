Feature: Change Profile
  Scenario:
    Given there is a user
    And the user is on the home page
    And the user is not logged in
    When the user goes to their profile page
    Then the user should not see an Edit link

  Scenario:
    Given there is a user
    And the user is on the home page
    When the user is logged in
    And the user goes to their profile page
    Then the user should see an Edit link

  Scenario:
    Given there is a user
    And the user is on the home page
    And the user is logged in
    When the user goes to their profile page
    And the user clicks Edit
    Then the user should be on the Edit Account page

  Scenario: No password given
    Given there is a user
    And the user is on the home page
    And the user is logged in
    And the user is on the Edit Account page
    When the user changes their name
    And the user presses Update My Account
    Then there will be a devise error: password can't be blank

  Scenario:
    Given there is a user
    And the user is on the home page
    And the user is logged in
    And the user is on the Edit Account page
    When the user changes their name
    And the user fills in their current password as: 12345678
    And the user presses Update My Account
    Then the user account will be updated
