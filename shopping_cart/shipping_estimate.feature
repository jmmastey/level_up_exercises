Feature: Shipping Estimate
   In order to test the shopping_cart application
   As a developer who plans to write it
   I want ensure a user can see shipping estimates

   Background:
     Given Cart holds 3 Sriver-3MM-Red, 4 Dozen-Nittaku-Yellow, 1 Yasaka-Stress-Net
     And user vists shipping page

   Scenario: Shipping estimates for 90210
     When user enters zip-code 90210
     Then user should see shipping estimate of 15.00

   Scenario: User enters non-domestic U.S. zip-code
     When user enters zip-code 96701
     Then user should see shipping not available message

   Scenario: User enters invalid zip-code and should see error message
     When user enters zip-code 99999
     Then user should see invalid zip-code message
