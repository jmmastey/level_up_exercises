class Event < ActiveRecord::Base
  lookup_for :event_source, :symbolize
    scope: :with_source, inverse_scope: :without_source
end
