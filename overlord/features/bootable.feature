Feature: Bomb can be booted
  In order to use my bomb in my evil plan
  As a super villian
  I want to boot my bomb

  Scenario: Arriving at the bomb
    Given I am ready to enact my evil plan
    When I go to my bomb
    Then I should see "Welcome to your Bomb!  It is waiting for you to boot it."

  Scenario: Unbooted bomb has no controls (except "Boot" button, of course)
    Given a newly constructed bomb
    Then I should not see "Control Panel"
    
  Scenario: Booting the bomb
    Given a newly constructed bomb
    When I press "Boot"
    Then I should see "Control Panel"
