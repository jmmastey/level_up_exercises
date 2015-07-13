@bomb_deactivation
Feature: Bomb Deactivation
    In order to stop the bomb from exploding
    As a super villain
    I want to allow deactivation of the bomb

    Scenario: super villain enters the correct deactivation code
        Given A bomb is active
        When Super villain enters the deactivation code "2233"
        And Super villain click the "Deactivate" button
        Then The bomb should deactivate
        And The bomb clearly shows it is inactive

    Scenario: super villain enters the incorrect deactivation code for the 3rd time
        Given A bomb is active
        And An incorrect deactivation code was already entered incorrectly 2 times since the bomb was activated
        When Super villain enters the deactivation code "9999"
        Then The should see a message that should say "Do not forget to recycle"
        And The bomb should explode
        And All buttons should be disabled


    Scenario: super villain enters the incorrect deactivation code for the 2nd time
        Given A bomb is active
        And An incorrect deactivation code was entered 1 since the bomb was activated
        When Super villain enters the deactivation code "9999"
        Then The should see a message that should say "Opps"
        And the Super villain should have attempts 1
        And The bomb not explode


    Scenario: super villain enters the incorrect deactivation code for the 1st time
        Given A bomb is active
        And An incorrect deactivation code was entered 0 since the bomb was activated
        When Super villain enters the deactivation code "9999"
        Then The should see a message that should say "Opps"
        And the Super villain should have attempts 2
        And The bomb not explode

