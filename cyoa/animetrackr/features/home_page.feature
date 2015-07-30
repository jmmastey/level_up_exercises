Feature: Home Page

  Scenario: View home page when not signed in
    Given I am signed out
    When I view the home page
    Then I should see home title
    And there should be a link to sign in
    And there should be a link to sign up
    And there should not be a link to sign out

  Scenario: When signed in, home page redirects to profile page
    Given I am signed in
    When I view the home page
    Then I should be redirected to the profile page
    And there should not be a link to sign in
    And there should not be a link to sign up
    And there should be a link to sign out

