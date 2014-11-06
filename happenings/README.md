## Local Events Feed

So there's a ton to do in the city of Chicago. So much, in fact, that it's pretty tough to figure out what you want to do. Meanwhile, the data you're looking for is, shall we say, a little tough to get. Take a look at this [opening night calendar](http://www.theatreinchicago.com/opening/openingnight.php) for instance.

### Doing Better

You're going to consume some data feeds and republish them in a format that someone could possibly use. Most calendar software can read [iCal](https://en.wikipedia.org/wiki/ICalendar), so that's where you'll export. So that you can 

* Start with the Theatre In Chicago calendar above. You'll add more feeds afterward, but it's got a pretty simple feed format.
* Figure out how to retrieve and parse events from the site and abstract that into a library.
* Expose the feed as an iCal feed. You should be able to add the calendar to your corporate Google Calendar and see events into the future.
* Don't hit the original API every time a page is requested. Grab the data on a schedule and store it locally.
* I'm pretty picky. Let me sign in and choose what data sources I want to see events from. You'll need to give me a customized calendar link.

### Extra Credit: More Feeds

Find more feeds, the wider the net you cast the better. I want to know more about [Restaurant Week](http://www.choosechicago.com/things-to-do/dining/chicago-restaurant-week/), and [Open House Chicago](http://www.openhousechicago.org/), and [Nightlife](http://do312.com/) (and oh God everything at the [iO Theatre](http://ioimprov.com/chicago/io/shows)).

### Extra Credit: Topics of Interest

Let me choose what data to see by keyword. There was a seriously cool event called [Trapped in a Room With a Zombie](http://www.zvents.com/chicago_il/events/show/368800640-january-trapped-in-a-room-with-a-zombie) and I want to see events for anything related to Zombies so I don't miss it again.
