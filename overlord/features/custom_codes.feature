Ability: Allow Custom Bomb Codes

  As a super-villain
  I need the ability to customize bomb activation and deactivation codes
  So that I do not rely on widely known default settings

  Scenario: Custom activation codes can be provided
    Given a bomb provisioned with a custom activation code of "9292"
    When the custom activation code is entered
    Then the bomb will display as active
