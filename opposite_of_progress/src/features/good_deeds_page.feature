# Feature: Good Deed Page
#   In order to have a idea about what's happening in the congress
#   As a user
#   I want to see all good deeds

#   Background:
#     Given I visit Good Deeds page

#   Scenario: Sees all good deeds
#     Given there are some good deeds
#     Then I see a list of good deeds

#   Scenario: Follows associated bill link to its own page
#     Given there are some good deeds
#     When I click associated bill link on one of them
#     Then I am on that bill's page

#   Scenario: Follows associated legislator links to his or her page
#     Given there are some good deeds
#     When I click associated legislator link on one of item
#     Then I am on that legislator's page

#   Scenario: Sees empty message when there is no good deeds
#     Given there are no good deeds
#     Then I see empty good deeds message

#   # Todo add feature for pagination
