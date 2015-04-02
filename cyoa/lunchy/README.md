## Lunchy

Lunchy is a lunch venue recommendation service. It uses data from Foursquare™ to find nearby restaurants.

Before running Lunchy for the first time, you will need to seed the database with venue data. A rake task has been provided to do this:

    rake import:venues

Currently the task has been hardcoded with the search center located at 200 W Jackson Blvd, and a search radius of 1200m.

The recommendation function is currently not very smart at all, as it will simply return a random entry from the venue database that matches the search criteria.

You can prevent Lunchy from recommended a specific restaurant by blacklisting it. Venues can be blacklisted on the "Venues" page.

You can also prevent Lunchy from recommending places that you've visited recently by adding venues to your history. When viewing recommendations, simply click the "Sold! I'm going" button to save the venue to your history. The visited date will simply be the current date. Once added to your history, you can control how many days Lunchy will wait before recommending it again via the "Repeat interval" setting.
