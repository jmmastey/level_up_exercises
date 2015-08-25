## Congressional Good Deeds Feed

Congress desperately needs some good news. As of writing approval rates [aren't just low](http://www.gallup.com/poll/171710/public-faith-congress-falls-again-hits-historic-low.aspx), they're the lowest approval ratings Gallup has ever seen for anything they measure, ever.

# Sunlight Foundation API

In order for the Sunlight Foundation to grant access to their API, you need to register [here](https://sunlightfoundation.com/api/accounts/register/). Once you obtain a key, use the [Figaro](https://github.com/laserlemon/figaro) gem to create the config/applicaton.yml file to store your environment variable.

```bash
bundle exec figaro install
```

In your config/application.yml,
```yml
SUNLIGHTLABS_APIKEY: 'my-api-key'
```

# Setup
```
git clone https://github.com/ssapra/good_deeds.git
cd good_deeds
bin/setup
rails server
```

### My Assignment

Build a Rails app that shows off some of the achievements of the current Congress as they happen. You may have to dig deep (they don't pass many laws lately), but there's got to be something. They just reduced their toilet paper budget again, 40% of bills get some kind of bi-partisan support and Colleen Hanabusa hasn't missed a day of attendance in her entire Congressional career.

Use the APIs provided by [The Sunlight Foundation](https://sunlightfoundation.com/api/) (they also provide the [OpenCongress API](http://www.opencongress.org/api)). The rules are as follows:

* Get the list of good deeds from the API.
* Expose those good deeds as a webpage. If you're segmenting based on bills, or congressmen, or parties etc, then provide pages for each of those folks.
* Perform some kind of transformation on the source data itself. Give me wiki links, or let me tweet my favorite deeds, or show me something interesting about the data. Who's got the best record?
* Don't hit the original API every time a page is requested. Grab the data on a schedule and store it locally.
* Since we love open data, republish the derivative data as a JSON feed.
* I'm a voter. Let me sign in and tag good deeds I'm interested in (my congressperson, or political party, etc) and get email alerts for new good deeds.

### Extra Credit: Send a Congress-person a Hug

Undoubtedly anyone who steps across your site will be ecstatic to hear that the sky is not in fact falling, but let's make it even easier for them to find out. Use Twilio to add a button to your site to allow users to call a Congress-person and congratulate them on their good deeds.
