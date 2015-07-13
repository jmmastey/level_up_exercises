@ignore @bomb_deactivation_configuration
Feature: Set a bomb Deactivation code
    In order to deactivate a bomb
    As a super villain
    I want to setup a secret deactivation code for the bomb

    Scenario: super villain does not enter a custom deactivation code
        Given A custom deactivation code was not provided
        When Super villain activates the bomb
        Then the bomb deactivation code should be default to 0000


    Scenario: super villain sets a custom deactivation code
        Given The bomb is not yet active
        When Super villain sets a custom deactivation code
        Then the bomb deactivation code should be set to the provided custom code