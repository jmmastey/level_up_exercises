                  Prefix Verb   URI Pattern                        Controller#Action

                 flights GET    /flights(.:format)                 flights#index
              new_flight GET    /flights/new(.:format)             flights#new
                  flight POST   /flights/create(.:format)          flights#create
             edit_flight GET    /flights/:id/edit(.:format)        flights#edit
                  flight GET    /flights/:id(.:format)             flights#show
         flight_manifest GET    /flights/:id/:manifest(.:format)   flights#manifest
             flight_trip GET    /flights/:id/:trip(.:format)       flights#trip
           flight_refuel GET    /flights/:id/:refuel(.:format)     flights#refuel

                airports GET    /airports(.:format)                airports#index
                 airport GET    /airports/:code(.:format)          airports#show

             itineraries GET    /itineraries(.:format)             itineraries#index
               itinerary GET    /itineraries/:id(.:format)         itineraries#show
                         PUT    /itineraries/:id(.:format)         itineraries#update
                         DELETE /itineraries/:id(.:format)         itineraries#destroy

              passengers GET    /passengers(.:format)              passengers#index
               passenger GET    /passengers/:id(:format)           passengers#show
               passenger POST   /passengers/create(.:format)       passengers#create
     passenger_itinerary GET    /passengers/:id/itinerary(:format) passengers#itinerary
                         PUT    /passengers/:id/itinerary(:format) passengers#update_itinerary
                         DELETE /passengers/:id/itinerary(:format) passengers#destroy_itinerary
