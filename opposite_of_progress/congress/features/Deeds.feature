Feature: Viewing the Deeds
  As an end-user
  I want to view good deeds
  So that I gain (some) respect for congress

  @happy
  Scenario:
    Given I am on the "home" page
    When I follow "Good Deeds"
    Then I should see "All Good Deeds" within "h3"
