Feature: Homepage
  In order to activate or deactivate the bomb
  As an evil overlord
  I should be able to set my own activation and deactivation codes

  Scenario: Homepage bomb status check
    Given I am on the starting page of the bomb
    Then The page should say "Bomb Status: Inactive"

  Scenario: Bomb should accept empty codes (for default values)
    Given I am on the starting page of the bomb
    When I click the "Submit" button
    Then I should be on the activation page

  Scenario: Input numeric activation code
    Given I specified my activation code as 1234
    Then I should be on the activation page

  Scenario: Input numeric deactivation code
    Given I specified my deactivation code as 1111
    Then I should be on the activation page

  Scenario: Input numeric activation and deactivation code
    Given I specified my activation code as "1111" and my deactivation code as "2222"
    Then I should be on the activation page

  Scenario: Input non-numeric activation code
    Given I specified my activation code as Password
    Then The page should say "Invalid activation code."

  Scenario: Input non-numeric deactivation code
    Given I specified my deactivation code as Password
    Then The page should say "Invalid deactivation code."