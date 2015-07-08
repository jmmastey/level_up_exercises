@bomb_activation
Feature: Activate A Bomb
    In order to activate a bomb
    As a super villain
    I want to arm a bomb

    Scenario: super villain enters bomb correct activation code in order to arm the bomb
        Given A bomb was booted
        When Super villain is entering the activation code for a bomb
        And The bomb is inactive
        And Super clicks the activate bomb button
        And Super villain does provide a correct activation code
        Then the bomb should be activated
        And the Super villain should see a message that the bomb was activated
        And the bomb should be armed

    Scenario: super villain enters bomb incorrect activation code in order to arm the bomb
        Given
        When Super villain is entering the wrong activation code for a bomb
        And The bomb is inactive
        And Super clicks the activate bomb button
        And Super villain provides an incorrect activation code
        Then the bomb should not be activated
        And the Super villain should see a message that the bomb is still inactive
        And the bomb should not be armed







