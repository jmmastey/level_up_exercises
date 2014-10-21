# The Center for Performance Art

* http://guides.rubyonrails.org/v3.2.13/performance_testing.html
* https://github.com/rails/rails-perftest
* http://martin.kleppmann.com/2008/10/27/load-performance-testing-a-rails-application-with-apachebench.html
* http://blog.newrelic.com/2009/06/25/load-testing-rails-new-railslab-episode/
* http://railscasts.com/episodes/411-performance-testing?view=comments
* https://loader.io/

Detection
+ (remote) Get off localhost.
+ (diagnose) Diagnosing performance problems (splunk? newrelic? generating realistic load?)
+ (premature) Not fixing problems that don't exist.
+ (profile) More realistic load profiles.

Refactoring
+ (import) Scale seed data creation properly. (https://www.coffeepowered.net/2009/01/23/mass-inserting-data-in-rails-without-killing-your-performance/)
+ (loop_invariant) Array inside a loop, string copies within a loop: `COUNTRY_CODE_MAP.detect? { |k,v| [k.downcase, v.downcase].include? string.downcase }`
+ (wrong_work) Move computation into the database
+ (include) Use `||` instead of `.include?` for small arrays
+ (pluck) Use `.pluck`, and other useful callbacks. (`delete_all` vs `destroy_all`)
+ (batches) Move to batch processing. Configure batch size.
+ (method_cache) Remove method cache clear by way of OpenStruct creation. (https://github.com/charliesome/charlie.bz/blob/master/posts/things-that-clear-rubys-method-cache.md)
+ (slow_tests) Slow unit tests, refactor to remove tons of extra data
+ (scope) Remove an unnecessary default scope that sorts on an expensive key.
+ (all) switch from User.all

Features
+ (memoize) Simple memoize
+ (n_plus_one) Solve an n+1 sql loading problem
+ (cache_expiry) Cache expiration keys and `touch: true`
+ (chunk_caching) Add page chunk caching
+ (page_caching) Add whole-page caching (move a dynmic block to JSON)
+ (pagination) Pagination?
+ (serializers) Move to https://github.com/dockyard/postgres_ext-serializers

Platform
+ (thread) Fix a non-threadsafe issue and move to Rubinius?
+ (redis) Add redis, memoize some methods into redis
+ (sidekiq) Defer execution using Sidekiq
+ (mongrel) Switch to a pack of Mongrels?
+ (cdn) Serve assets from nginx
+ (faraday) Adding SOA-caching via Faraday
