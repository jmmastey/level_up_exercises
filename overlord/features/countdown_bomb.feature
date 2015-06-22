Feature:  bomb count down

  As a bomb maker
  I want my bomb to be able to count down
  and explode automatically after countdown

  Scenario: countdown
    Given that I am on the countdown bomb page
    When 10 seconds has passed
    Then my bomb should explode

