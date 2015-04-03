## Traffic Control - Routes for Humans

You've been hired by a progressive airline (probably something European, not thinking of United here) to help build an API to their traffic control system. Other airlines and amateur aviation nuts (and travel agencies, if they still exist somewhere) will use this API to query and modify manifests for that airline.

Your first goal is to define the API. You're smart enough to realize that writing the API and having it grow organically is going to make for some crappy code, so you're going to define the endpoints first before you do anything else.

## Requirements

* Build the set of routes necessary for the airline API. Assume that there will not be any useful documentation for this API, so it has to be comprehensible on its own.
* The output should be a text file that looks like the output from the `rake routes` command. Give example usage for anything even remotely complicated.
* At minimum, support the following functionality:
  * For a given flight, get a manifest of passengers, and details of the flight. Add or remove bookings from that flight (also I may change my mind on my food preferences or seating). I may need to re-route airplanes for various reasons, so let me do that as well.
  * See the trip an airplane will make regardless of individual itineraries. See when the airplane will have to refuel during those trips. Also, when I maintenance an airplane, I need to update information on the vehicle. Who needs security anyway?
  * Find flights matching some search criteria.
  * Get details on an airport or destination (use the airport code for this).
  * Get a list of itineraries with flights for a given passenger.
