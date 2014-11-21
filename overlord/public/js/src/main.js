var $ = require('jquery');
var moment = require('moment');
var JSConsole = require('./components/console');


$(function() {
  var jsConsole = JSConsole({
    commands: commands()
  });

  getState.call(jsConsole).then(function (data, status, res) {
    jsConsole.log("\nBomb state: " + data.bomb_state);

    if (!data.detonation) {
      return $.Deferred().resolve(data, status, res);
    }

    return detonationCountdown.call(jsConsole, data.detonation, status, res).then(function () {
      return getState.call(jsConsole);
    }).then(function (data) {
      jsConsole.log("\nBomb detonated");
    });
  });


  $('[data-js="fullscreen-console"]').on('click', function (e) {
    e.preventDefault();
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
    help: 'outputs current user',
    callback: function () {
      this.log("Overlord\n");
    }
  }, {
    name: 'state',
    desc: 'get the bomb\'s current state',
    help: 'get the bomb\'s current state',
    callback: function () {
      var self = this;
      getState.call(this).done(function (res) {
         self.log("\n" + res.bomb_state + "\n");
      });
    }
  }, {
    name: 'activate',
    desc: 'activate the bomb',
    help: 'activate the bomb with a password\nUsage: activate [password-string]',
    callback: updateState('active')
  }, {
    name: 'deactivate',
    desc: 'deactivate the bomb',
    help: 'deactivate the bomb with a password\nUsage: deactivate [password-string]',
    callback: updateState('inactive')
  }, {
    name: 'detonate',
    desc: 'detonate the bomb',
    help: 'deactivate the bomb in <n> seconds\nUsage: detonate [countdown-seconds]',
    callback: detonationSequence
  }, {
    name: 'register',
    desc: 'register custom activation/deactivation codes',
    help: 'register custom activation/deactivation codes\nUsage: register [activation|deactivation] [password-string]',
    callback: registerNewCodes
  }];
}

function registerNewCodes (args) {
  var jsConsole = this;
  var deferred = $.Deferred();
  var loader = dotLoader(function (dots) {
    jsConsole.output_elm.append(dots);
  });
  var params = {
    register_for: args[0],
    code: args[1]
  };

  $.post('/api/custom_code', params).then(function (data, status, res) {
    if (!data || data.error) {
      if (data.error) jsConsole.log("\n" + data.error);
      return deferred.reject(res);
    }
    jsConsole.log("\nNew " + params.register_for + " code registered");
  }).fail(function () {
    jsConsole.log("\nERROR: could not register code");
  }).always(function (argument) {
    clearInterval(loader);
  });
}

/**
 * callback for 'detonate' command
 * @param  {Array} args
 */
function detonationSequence (args) {
  var jsConsole = this;
  var deferred = $.Deferred();
  var loader = dotLoader(function (dots) {
    jsConsole.output_elm.append(dots);
  });

  getState.call(jsConsole).then(function (data, status, res) {
    clearTimeout(loader);
    if (!data.bomb_state || data.bomb_state == 'inactive') {
      return deferred.reject(res, "inactive");
    }
    return $.post('/api/detonate', {wait: args[0] || 3});
  }).then(function (data, status, res) {
    return detonationCountdown.call(jsConsole, data, status, res);
  }).then(function () {
    return getState.call(jsConsole);
  }).then(function (data) {
    jsConsole.log("\nBomb detonated");
  }).fail(function (e) {
    jsConsole.log("\nERROR: can't launch bomb");
  });
}

/**
 * detonationCountdown bomb callback
 * @param  {[type]} args [description]
 * @return {[type]}      [description]
 */
function detonationCountdown (data, status, res) {

  var jsConsole       = this;
  var now             = moment();
  var zero_hour       = moment(data.zero_hour, 'YYYY-MM-DD HH:mm:ss Z');
  var ms_remaining    = zero_hour - now;
  var lines           = jsConsole.output_elm.text().split('\n');
  var deferred        = $.Deferred();
  var lessThanZero;

  lines.push(''); // add an empty line to put our timer in

  window.countdown = setInterval(function () {

    lessThanZero = ms_remaining < 0;

    lines[lines.length - 1] = 'Bomb detonating in: ' + (lessThanZero ? '0.0' : (ms_remaining / 1000)) + 's';
    jsConsole.output_elm.text(lines.join('\n'));
    ms_remaining -= 100;

    if (lessThanZero) {
      clearInterval(window.countdown);
      return deferred.resolve(data, status, res);
    }
  }, 100);

  return deferred;
}

/**
 * update bomb state
 * @param  {String} state
 * @return {Function}
 */
function updateState (state) {
  return function (args) {
    var jsConsole = this;
    var loader = dotLoader(function (dots) {
      jsConsole.output_elm.append(dots);
    });
    var params = {
      state: state,
      pass: args[0]
    };

    $.post('/api/state', params).done(function (res) {
      jsConsole.log("\nBomb is " + res.bomb_state + "\n");

      if (res.bomb_state == 'inactive' && window.countdown) {
        clearInterval(window.countdown);
        jsConsole.log("\nDetonation sequence cancelled");
      }
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
    i += 1;
    fn(Array(i).join('. ')); // return a string of i number of dots...
  }, speed);
}
