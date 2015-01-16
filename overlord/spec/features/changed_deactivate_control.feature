Feature: Control the Bomb with Changed Deactivation Code
	In order to make sure we can use a bomb safely
  As a super villain
  I want to be able to control the bomb after changing the deactivation code

  Background:
  	Given I have booted the bomb
  	And I change the deactivation code to "3264"
    And I enter the default activation code 1 time(s)
    And the status indicator shows as activated

  Scenario Outline: Try to deactivate the bomb
    When I enter <code> <times> time(s)
    Then the status indicator shows as <status>
    And the buttons <work>

  @happy
  Examples: Correct code
    | code            | times | status      | work |
    | the code "3264" | 1     | deactivated | work |

  @sad
  Examples: Incorrect code
    | code                          | times | status    | work        |
    | the code "1111"               | 1     | activated | work        |
    | the default deactivation code | 1     | activated | work        |
    | the code "1111"               | 3     | detonated | do not work |