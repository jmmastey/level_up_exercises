Feature: Control the Bomb with Changed Activation Code
	In order to make sure we can use a bomb safely
  As a super villain
  I want to be able to control the bomb after changing the activation code

  Background:
  	Given I have booted the bomb
  	And I change the activation code to "8759"

  Scenario Outline: Try to activate the bomb
    When I enter <code> <times> time(s)
    Then the status indicator shows as <status>

  @happy
  Examples: Correct code
    | code            | times | status    |
    | the code "8759" | 1     | activated |

  @sad
  Examples: Incorrect code
    | code                        | times | status      |
    | the code "1111"             | 1     | deactivated |
    | the default activation code | 1     | deactivated |