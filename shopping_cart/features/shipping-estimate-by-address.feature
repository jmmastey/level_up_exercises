Feature: User logged in sees shipping estimates for address associated with
         profile

  Happy:
    
Feature: Authnd user enters address for shipping estimates overriding profile
        address


Feature: Anon user enters address for shipping estimates

  Happy:
    User enters valid address: Shipping estimates appear and popup offers to 
    save data (ie register her)
  Sad:
    User enters invalid address: No shipping estimates appear and popup offers
    to save data (ie register her)
  Bad:
    User enters ill-formatted address that can't be checked for validity: No
    shipping estimates appear and popup offers to save data
    User enters HTML/SQL/Javascript in order to subvert proper application
    operation or affect display of deliberatewly misleading rendered content by
    incorporation w/in the HTML document: No such effects are produced


