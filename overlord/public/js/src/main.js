var $ = require('jquery');

var JSConsole = require('./components/console');


$(function() {
  var jsConsole = JSConsole({
    commands: commands()
  });

  getState.call(jsConsole).done(function (res) {
    jsConsole.log("\nBomb state: " + res.data.session.bomb_state + "\n");
  });

  $('.js-console-submit').on('click', function () {
    jsConsole.submit_query();
  });

  $('[data-js="fullscreen-console"]').on('click', function () {
    $('.desk').toggleClass('active');
  });

  $('body').addClass('js-ready');
});


/*==========  ...  ==========*/

/**
 * index of custom commands
 * @return {Array}
 */
function commands () {
  return [{
    name: 'whoami',
    desc: 'outputs current user',
    callback: function () {
      this.log("Overlord\n");
    }
  }, {
    name: 'state',
    desc: 'get the bomb\'s current state',
    callback: function () {
      var self = this;
      getState.call(this).done(function (res) {
         self.log("\n" + res.data.session.bomb_state + "\n");
      });
    }
  }, {
    name: 'activate',
    desc: 'activate the bomb',
    help: 'activate the bomb with a password\nUsage: activate 1234',
    callback: updateState('active')
  }, {
    name: 'deactivate',
    desc: 'deactivate the bomb',
    help: 'deactivate the bomb with a password\nUsage: deactivate 0000',
    callback: updateState('inactive')
  }, {
    name: 'detonate',
    desc: 'detonate the bomb',
    help: 'deactivate the bomb in <n> seconds\nUsage: detonate 10',
    callback: detonate
  }];
}

/**
 * detonate bomb callback
 * @param  {[type]} args [description]
 * @return {[type]}      [description]
 */
function detonate (args) {
  debugger;
}

/**
 * update bomb state
 * @param  {String} state
 * @return {Promise}
 */
function updateState (state) {

  return function (args) {
    var self = this;
    var loader = dotLoader(function (dots) {
      self.output_elm.append(dots);
    });

    var data = {
      state: state,
      pass: args[0]
    };

    $.post('/api/state', data).done(function (res) {
      self.log("\nBomb is " + res.data.session.bomb_state + "\n");
    }).always(function () {
      clearTimeout(loader);
    });
  };
}

/**
 * get current bomb state
 * @return {Promise}
 */
function getState () {
  var self = this;
  var loader = dotLoader(function (dots) {
    self.output_elm.append(dots);
  });

  return $.get('/api/state').always(function () {
    clearTimeout(loader);
  });
}

/**
 * adds dots to the screen
 * @param  {Function} fn
 * @return {Interval}
 */
function dotLoader (fn, speed) {
  var i = 0;
  speed = speed || 20;

  return setInterval(function () {
    i++;
    fn(Array(i).join('. '));
  }, speed);
}
