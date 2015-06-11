Feature: Login
  In order to keep my bomb secure
  As a villain
  I should only allow known users to enter the site

  Scenario: Redirect to Login
    When I visit the bomb page
    Then I should be redirected to the home page

  Scenario Outline: Login redirects to bomb
    When I login as <username>
    Then I should be redirected to the <redirect_page> page
    And I should be logged in as <user>

    Examples:
      | username | redirect_page | user    |
      | villain  | bomb          | villian |
      | dev      | bomb          | dev     |
      | generic  | bomb          | generic |

  Scenario: Logout redirects to home
    Given I am logged in as "generic"
    When I click the logout link
    Then I should be redirected to the home page
    And I should not be logged in
