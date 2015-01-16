Feature: Boot the bomb
  In order to control a bomb
  As a super villain
  I want to boot the bomb safely

  Background:
  	Given I have booted the bomb

  Scenario Outline: Configure without activating
  	When I <choose_a_configuration>
  	Then the status indicator shows as deactivated
  
  @happy
  Examples:
  	| choose_a_configuration			         |
  	| change no configuration code         |
  	| change the activation code to "8759" |