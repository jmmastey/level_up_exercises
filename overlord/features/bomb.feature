Feature: Activation

Scenario: Configure activation code and activate bomb
Given I configure codes to '4087' and '8991'
When I fill in '4087' to activate my bomb
Then I should see 'Bomb activated'

Scenario: Accept only numeric inputs
Given I visit bomb boot setup page
When I fill in '23B4' for 'activation'
Then I should remain on boom boot page

Scenario: Default code for activation is 1234
Given I dont configure codes
When I fill in '1234' to activate my bomb
Then I should see 'Bomb activated'

Scenario: Configure deactivation code and deactivate bomb
Given I configure codes to '3671' and '7609'
And I fill in '3671' to activate my bomb
When I fill in '7609' to deactivate my bomb
Then I should see 'Bomb has been deactivated'

Scenario: Default code for deactivation is 0000
Given I dont configure codes
And I activate the bomb
When I fill in '7609' to deactivate my bomb
Then I should see 'Bomb has been deactivated'

Scenario: Three mis-attempts should activate bomb
Given I configure codes to '1234' and '0000'
When I enter the activation code wrong three times
Then I should see 'You had three attempts to activate bomb'






