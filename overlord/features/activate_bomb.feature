Feature: villain activates bomb
    
    As a villain
    I want to activate a bomb
    So that I can have it explode

    Background:
        Given a bomb has been created with 1234, 4321, 5 as inputs
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
