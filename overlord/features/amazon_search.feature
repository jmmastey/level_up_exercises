Feature: Shopping in Amazon
    As an internet user
    I want to search stuff on Amazon
    So that I can choose and buy items I like
    @skip @ignore @javascript
    Scenario: Search for baseball gloves
        Given I am on Amazon homepage
        When I enter "baseball glove" in the search box
        And I click "Go" button
        Then I should see a list of results related with Baseball Gloves