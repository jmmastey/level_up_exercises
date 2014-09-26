### Current thoughts:

* Go through RailsGoat. If we can get this installed, that should do 90% of the work.
* Use something like SqlMap to discover vulns.
* Use something like Burp to walk through requests. Use the scanner?
* Do static code analysis with brakeman + bundler-audit
* Define some common terms
  - Defense in depth
  - accountability, reputiability, confidentiality etc
  - blacklist -> whitelist
* git:// repos don't use SSL
* cookie config for secure=1
* X-Content-Type-Options: nosniff
