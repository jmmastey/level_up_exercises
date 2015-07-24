Feature: Homepage
  In order to activate or deactivate the bomb
  As an evil overlord
  I should be able to set my own activation and deactivation codes

  Scenario: Homepage bomb status check
    Given I am on the home page
    Then I should see "Bomb Status: Inactive"

  Scenario: Bomb should accept empty codes (for default values)
    Given I am on the home page
    When I press "Submit"
    Then I should be on the activation page

  Scenario: Input numeric activation code
    Given I am on the home page
    And I fill in "activation" with "1111"
    When I press "Submit"
    Then I should be on the activation page

  Scenario: Input numeric deactivation code
    Given I am on the home page
    When I fill in "deactivation" with "1111"
    When I press "Submit"
    Then I should be on the activation page

  Scenario: Input numeric activation and deactivation code
    Given I am on the home page
    When I fill in "activation" with "1111"
    And I fill in "deactivation" with "2222"
    When I press "Submit"
    Then I should be on the activation page

  Scenario: Input non-numeric activation code
    Given I am on the home page
    And I fill in "activation" with "Password"
    When I press "Submit"
    Then I should see "Invalid activation code."

  Scenario: Input non-numeric deactivation code
    Given I am on the home page
    And I fill in "deactivation" with "Password"
    When I press "Submit"
    Then I should see "Invalid deactivation code."