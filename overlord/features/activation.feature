Feature: Activation
  In order to activate the bomb
  As an evil overlord
  I should be able to input my specified activation code

  Scenario: Attempt to jump directly to the activation page
    Given I am on "the activation page" of the bomb
    Then I should be on the starting page

  Scenario: Correctly displays bomb status
    Given I create a new bomb
    Then The page should say "Bomb Status: Inactive"

  Scenario: Accepts the default activation code
    Given I create a new bomb
    When I try the default activation code
    Then I should be on the deactivation page

  Scenario: Accepts a specified activation code
    Given I specified my "activation" code as "1111"
    When I try to activate the bomb with the code "1111"
    Then I should be on the deactivation page

  Scenario: Double activation should have no effect
    Given I activated the bomb with the deactivation code ""
    And I try to load "the activation page" of the bomb
    When I try to activate the bomb with the code "1234"
    Then I should be on the deactivation page

  Scenario: Incorrect activation code
    Given I specified my "activation" code as "1234"
    When I try to activate the bomb with the code "1111"
    Then I should be on the activation page

   Scenario: Incorrect non-numeric activation code (shouldn't accept for security)
     Given I create a new bomb
     When I try to activate the bomb with the code "Hello"
     Then I should be on the activation page