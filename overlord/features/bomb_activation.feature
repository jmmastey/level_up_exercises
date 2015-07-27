@javascript @bomb_activation
Feature: Activate A Bomb
    In order to activate a bomb
    As a super villain
    I want to arm a bomb

    Scenario: I enter a bomb correct activation code in order to arm the bomb
        Given A bomb was booted with activation code 8888
        And The bomb is unarmed
        When I enter the activation code 8888 for a bomb
        Then The bomb is armed

    Scenario: I enter a bomb incorrect activation code in order to arm the bomb
        Given A bomb was booted with activation code 8888
        And The bomb is unarmed
        When I enter the activation code 7777 for a bomb
        Then The bomb is unarmed
