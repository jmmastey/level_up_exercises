## EVE Central
Provides a wrapper for the [EVE Central API](http://dev.eve-central.com/evec-api/start) methods.

### Market Statistics
Retrieves aggregate statistics for the items specified.

```ruby
market_client = EveCentral::Marketstat.new
market_stats = market_client.request(34)        # Pull market statistics for Tritanium
```

### Quicklook
Retrieves order data from the past few days.

```ruby
quicklook_client = EveCentral::Quicklook.new
order_info = quicklook_client.request(34)       # Pull orders from the past few days for Tritanium
```
