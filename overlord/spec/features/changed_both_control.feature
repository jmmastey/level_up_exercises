Feature: Control the Bomb with Both Codes Changed
	In order to make sure we can use a bomb safely
  As a super villain
  I want to be able to control the bomb after changing both codes

  Background:
  	Given I have booted the bomb
  	And I fill in the activation code as "9385"
    And I fill in the deactivation code as "3264"
    And I submit the configuration

  Scenario Outline: Try to control the bomb
    Given I enter <first_code> <first_times> time(s)
    And the status indicator shows as <first_status>
    When I enter <second_code> <second_times> time(s)
    Then the status indicator shows as <second_status>
    And the buttons <work>

  @happy
  Examples: Correct code
    | first_code      | first_times | first_status | second_code                   | second_times | second_status   | work        |
    | the code "9385" | 1           | activated    | the code "3264"               | 1            | deactivated     | work        |

  @sad
  Examples: Incorrect code
    | first_code      | first_times | first_status   | second_code                   | second_times | second_status     | work        |
    | the code "9385" | 1           | activated      | the code "1111"               | 1            | activated         | work        |
    | the code "9385" | 1           | activated      | the default deactivation code | 1            | activated         | work        |
    | the code "1111" | 1           | deactivated    | the code "3264"               | 1            | activated         | work        |
    | the code "1111" | 1           | deactivated    | the code "1111"               | 1            | deactivated       | work        |
    | the code "1111" | 1           | deactivated    | the code "1111"               | 3            | deactivated       | work        |
    | the code "9385" | 1           | activated      | the code "1111"               | 3            | detonated         | do not work |