## EVE Central
Provides a wrapper for the [EVE Central API](http://dev.eve-central.com/evec-api/start) methods.

### Market Statistics
Retrieves aggregate statistics for the items specified.

```ruby
TRITANIUM_ID = 34

market_client = EveCentral::Marketstat.new
market_stats = market_client.request(TRITANIUM_ID)
```
