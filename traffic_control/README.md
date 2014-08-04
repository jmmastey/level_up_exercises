## Traffic Control - Routes for Humans

You've been hired by a progressive airline (probably something European, not thinking of United here) to help build an API to their traffic control system. Other airlines and amateur aviation nuts (and travel agencies, if they still exist somewher) will use this API to query and modify manifests for that airline.

Your first goal is to define the API. You're smart enough to realize that writing the API and having it grow organically is going to make for some crappy code, so you're going to define the endpoints first before you do anything else.

## Requirements

* Build the set of routes necessary for the airline API. Assume that there will not be any useful documentation for this API, so it has to be comprehensible on its own.
* The output should look similar to the output from the `rake -T` command. Give example usage for anything even remotely complicated.
* At minimum, support the following functionality:
  * Get a manifest of passengers for a given flight.
  * Get details on a given flight
  * See the trip an airplane will make regardless of individual itineraries.
  * See when the airplane will have to refuel during that trip.
  * Find flights matching some criteria
  * Get details on an airport or destination (use the airport code for this)
  * Get a list of itineraries with flights for a given passenger.
  * For modifying data:
    * Create new bookings
    * Reroute airplanes through new itineraries
