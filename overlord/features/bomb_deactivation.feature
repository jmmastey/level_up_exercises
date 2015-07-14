@javascript @bomb_deactivation
Feature: Bomb Deactivation
    In order to stop the bomb from exploding
    As a super villain
    I want to allow deactivation of the bomb

    Scenario: super villain enters the correct deactivation code
        Given A bomb is active
        When I apply the deactivation code "2233"
        Then The bomb should deactivate
        And The bomb clearly shows it is inactive

    Scenario: super villain enters the incorrect deactivation code for the 3rd time
        Given A bomb is active
        And An incorrect deactivation code was already entered incorrectly 2 times since the bomb was activated
        When I apply the deactivation code "9999"
        Then The should see a message that should say "Do not forget to recycle"
        And The bomb should explode
        And All buttons should be disabled


    Scenario: super villain enters the incorrect deactivation code for the 2nd time
        Given A bomb is active
        And An incorrect deactivation code was entered 1 since the bomb was activated
        When I apply the deactivation code "9999"
        Then The see a message that should say deactivation failed
        And I see that I have 1 attempts left
        And The bomb should not explode


    Scenario: super villain enters the incorrect deactivation code for the 1st time
        Given A bomb is active
        And An incorrect deactivation code was entered 0 since the bomb was activated
        When I apply the deactivation code "9999"
        Then The see a message that should say deactivation failed
        And I see that I have 2 attempts left
        And The bomb should not explode

