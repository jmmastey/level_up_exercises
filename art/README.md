# The Center for Performance Art

* Diagnosing performance problems (splunk? newrelic? generating realistic load?)
* Add redis, memoize some methods into redis
* Add page chunk caching
* Add whole-page caching (move a dynmic block to JSON)
* Cache expiration keys and `touch: true`
* Defer execution using Sidekiq
* Fix a non-threadsafe issue and move to Rubinius?
* Switch to a pack of Mongrels?
* Move assets to a CDN (or at least serve from nginx)
* Squid or other reverse-proxy
* Adding SOA-caching via Faraday
* Simple memoize
* Solve an n+1 sql loading problem
* Array inside a loop, string copies within a loop: `COUNTRY_CODE_MAP.detect? { |k,v| [k.downcase, v.downcase].include? string.downcase }`
* Use `||` instead of `.include?` for small arrays
* Use `.pluck`, and other useful callbacks. (`delete_all` vs `destroy_all`)
