@bomb_activation
Feature: Activate A Bomb
    In order to activate a bomb
    As a super villain
    I want to arm a bomb

    @javascript
    Scenario: super villain enters bomb correct activation code in order to arm the bomb
        Given A bomb was booted
        When I enter the activation code 8888 for a bomb
        And The bomb is inactive
        And I activate a bomb
        Then I see a message that the bomb was activated
        And the bomb should be armed

    @javascript
    Scenario: super villain enters bomb incorrect activation code in order to arm the bomb
        Given A bomb was booted
        When I enter the activation code 7777 for a bomb
        And The bomb is inactive
        And I activate a bomb
        Then the bomb should not be activated
        And I see a message that the bomb is still inactive
        And the bomb should not be armed







