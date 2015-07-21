@bomb_setup
Feature: Set a bomb Deactivation code
    In order to deactivate a bomb
    As a super villain
    I want to setup a secret deactivation code for the bomb

    Scenario: super villain does not enter a custom deactivation code
        Given A bomb is booted
        When I do not enter a a custom deactivation code
        Then the bomb deactivation code should be set to 0000

    Scenario: super villain enters a custom deactivation code
        Given A bomb is booted
        When I enter a a custom deactivation code 4321
        Then the bomb deactivation code should be set to 4321

