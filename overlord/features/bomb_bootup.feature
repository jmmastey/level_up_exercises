@ignore @bomb_setup
Feature: Boot And Set A Bomb
 In order to prepare bombs
 As a super villain
 I want to boot and set a bomb

Scenario: super villain boots a bomb for the first time without providing a custom activation code
Given Super villain is booting a bomb
When Super villain is on the main page
And Super villain clicks the "New bomb" button
And Super villain does not provide a custom activation code
When the bomb boots
Then the bomb should not be activated
And the Super villain should see a message that a new bomb was created
And the bomb activation code should be set to 1234

Scenario: super villain boots a bomb for the first time providing a custom numeric activation code
 Given Super villain is booting a bomb
 When Super villain is on the main page
 And Super villain clicks the "New bomb" button
 And Super villain does provide a custom activation code "8888"
 When the bomb boots
 Then the bomb should not be activated
 And the Super villain should see a message that a new bomb was created
 And the bomb activation code should be set to 8888

 Scenario: super villain boots a bomb for the first time providing a custom non numeric activation code
  Given Super villain is booting a bomb
  When Super villain is on the main page
  And Super villain clicks the "New bomb" button
  And Super villain does provide a custom activation code "8AA8"
  Then the bomb should not be activated
  And the Super villain should see a message that a new bomb was not created

 Scenario: super villain enters the same activation code for an already activated bomb
  Given Super villain has an already booted and activated the bomb
  When Super villain is on the main page
  And Super villain does provide a custom activation code "9999"
  Then the bomb should not be activated
  And the bomb activation code should not change



