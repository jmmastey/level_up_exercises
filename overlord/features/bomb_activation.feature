@ignore @bomb_activation
Feature: Activate A Bomb
    In order to activate a bomb
    As a super villain
    I want to arm a bomb

    Scenario: super villain enters bomb correct activation code in order to arm the bomb
        Given A bomb was booted
        When Super villain is entering the activation code 8888 for a bomb
        And The bomb is inactive
        And Super villain clicks the "Activate bomb" button
        Then the Super villain should see a message that the bomb was activated
        And the bomb should be armed

    Scenario: super villain enters bomb incorrect activation code in order to arm the bomb
        Given A bomb was booted
        When Super villain is entering the activation code 7777 for a bomb
        And The bomb is inactive
        And Super villain clicks the "Activate bomb" button
        Then the bomb should not be activated
        And the Super villain should see a message that the bomb is still inactive
        And the bomb should not be armed







