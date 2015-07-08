@bomb_deactivation
Feature: Bomb Deactivation
    In order to stop the bomb from exploding
    As a super villain
    I want to allow deactivation of the bomb

    Scenario: super villain enters the correct deactivation code
        Given A bomb is active
        When Super villain enters the deactivation code
        And The Code is correct
        Then The bomb should deactivate
        And The bomb clearly shows it is inactive

    Scenario: super villain enters the incorrect deactivation code for the 3rd time
        Given A bomb is active
        And An incorrect deactivation code was already entered incorrectly 2 times since the bomb was activated
        When Super villain enters a deactivation code
        And The Code is incorrect
        Then The should see a message that should say "Do not forget to recycle"
        And The bomb should explode
        And All buttons should be disabled


    Scenario: super villain enters the incorrect deactivation code for the 1st or 2nd time
        Given A bomb is active
        And An incorrect deactivation code was entered 1st or 2nd time since the bomb was activated
        When Super villain enters a deactivation code
        And The Code is incorrect
        Then The should see a message that should say "Opps"
        And The bomb not explode