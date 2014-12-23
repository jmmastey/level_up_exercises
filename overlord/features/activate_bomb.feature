Feature: villain activates bomb
    
    As a villain
    I want to activate a bomb
    So that I can have it explode

    Background:
        Given a bomb has been created
        And I'm on the inactive bomb page

    Scenario Outline: activating bomb
        When I activate a bomb with <code>
        Then I expect to be warned that the bomb is <bomb_status>

      Examples:
        | code      | bomb_status                         |
        |  1234     |  "Bomb Status: ACTIVE"              |
        |  "1234"   |  "Bomb Status: ACTIVE"              |
        |  " "      |  "Incorrect code - bomb not active" |
        |  999      |  "Incorrect code - bomb not active" |
        |  "@#^#@#" |  "Incorrect code - bomb not active" |


# ==========================================================
# The outline above should replace the code below. 
# I left the scenarios below as a precation. Delete them
# ==========================================================

    Scenario: Activate Bomb
        When I activate a bomb with a correct numeric code
        Then I expect to be warned that the bomb is active

    Scenario: Activate Bomb
        When I activate a bomb with a correct string code
        Then I expect to be warned that the bomb is active

    Scenario: Activate Bomb
        When I activate a bomb with an incorrect code
        Then I expect to be warned that the bomb is not active

    Scenario: Activate Bomb
        When I activate a bomb with non-alphanumeric codes
        Then I expect to be warned that the bomb is not active
    
    Scenario: Activate bomb with no code 
        When I activate a bomb with no code
        Then I expect to be warned that the bomb is not active
