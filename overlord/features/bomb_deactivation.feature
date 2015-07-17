@javascript @bomb_deactivation
Feature: Bomb Deactivation
    In order to stop the bomb from exploding
    As a super villain
    I want to allow deactivation of the bomb

    Scenario: super villain enters the correct deactivation code
        Given A bomb is active and armed
        When I apply the disarming code "0000"
        Then The bomb should deactivate
        And The see a message that should say deactivation was successful

    Scenario: super villain enters the incorrect deactivation code for the 1st time
        Given A bomb is active and armed
        And An incorrect disarming code 7777 was entered 0 times since the bomb was activated
        When I apply the disarming code "9999"
        Then I see that I have 2 attempts left
        And The see a message that should say deactivation failed
        And The bomb should not explode

    Scenario: super villain enters the incorrect deactivation code for the 2nd time
        Given A bomb is active and armed
        And An incorrect disarming code 7777 was entered 1 times since the bomb was activated
        When I apply the disarming code "9999"
        Then The see a message that should say deactivation failed
        And I see that I have 1 attempts left
        And The bomb should not explode

    Scenario: super villain enters the incorrect deactivation code for the 3rd time
        Given A bomb is active and armed
        And An incorrect disarming code 7777 was entered 2 times since the bomb was activated
        When I apply the disarming code "9999"
#        Then The should see a message that should say "Do not forget to recycle"
        And The bomb should explode
#        And All buttons should be disabled
