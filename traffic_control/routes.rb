Rails.application.routes.draw do
  resources :flights, only: [:show, :index] do
    collection do
      get 'search'
    end

    resources :passengers, only: [:index] do
    end
  end

  resources :planes, only: [:show, :index] do
    collection do
      get 'reroute'
    end

    resources :trips, only: [:index] do
      get 'refuel_stops'
    end
  end

  resources :passengers, only: [:index, :show] do
    resources :itenaries, only: [:index] do
      resources :flights, only: [:index]
    end

    resources :bookings, only: [:create]
  end

  constraints id: /[A-Z]{3}/ do # Supports IATA 3-letter airport codes
    resources :destinations, only: [:show, :index]
  end
end
