// modified from http://codepen.io/john052/pen/IuLFa


var $ = require('jquery');

function jsConsole (opts) {

  // save common elements
  this.$parent_elm = $(opts.parent_elm);
  this.input_elm = $(opts.input_elm);
  this.output_elm = $(opts.output_elm);
  this.content_elm = $(opts.content_elm);
  this.cmd_prompt = opts.cmd_prompt;

  this.cmd_list = [];
  this.cmd_history = [];
  this.cmd_histroy_size = 16;
  this.cmd_index = -1;

  this.in_buffer = "";
  this.tmp_buffer = "";
  this.input_buffer_max = 256;

  // apply the commands
  opts.commands.forEach(function (command) {
    this.add_cmd(command);
  }, this);

  // emit ready event
  this.$parent_elm.trigger('jsConsole.ready');
}

jsConsole.prototype.bind_events = function () {
  var self = this;

  // prevent default browser navigation :(
  $(document).on('keydown', function (event) {
    var key = event.keyCode;
    if (key === 8 || (key >= 37 && key <= 40)) {
      self.handle_key.call(self, event);
      return false;
    }
  });

  // handle other keys in the keypress event
  $(document).on('keypress', function (event) {
    self.handle_key.call(self, event);
  });
};

jsConsole.prototype.submit_query = function () {
  // enter key pressed. parse then run the command
  // echo the command and clear the input
  var cmd_string = this.in_buffer;
  this.input_clear();
  this.log(this.cmd_prompt + cmd_string);

  // reset the history pointer and add the command if it parsed. i.e not empty
  this.cmd_index = -1;

  // parse the string to get the command and arguments
  var cmd_obj = this.parse_cmd(cmd_string);

  // if th ecommand is not empty, run the command and save the command string to the history
  if (cmd_obj.cmd !== "") {
    this.run_cmd(cmd_obj.cmd, cmd_obj.args);
    this.add_cmd_history(cmd_string);
  }
};

jsConsole.prototype.handle_key = function (event) {
  var self = this;

  switch (event.keyCode) {
    case 10:
      return;
    case 8:
      return backspace();
    case 13:
      return self.submit_query();
    case 0: case 37: case 38: case 39: case 40:
      return arrowKeys();
    default:
      return allKeys();
  }

  function backspace () {
    self.input_log(self.in_buffer.slice(0, self.in_buffer.length-1));
  }

  function arrowKeys (argument) {
    // arrow keys
    // key up and down. use to move up and down through the history
    if (event.keyCode === 38) {
      if (self.cmd_history.length > 0) {
        if (self.cmd_index < self.cmd_history.length-1) self.cmd_index++;

        self.in_buffer = self.cmd_history[self.cmd_index];
        self.input_log(self.in_buffer);
      }
    } else if (event.keyCode === 40) {
      // down key pressed
      if (self.cmd_index > -1 ) {
        self.cmd_index--;
        self.input_log(self.cmd_history[self.cmd_index]);
      } else {
        self.input_log("");
      }
    }
  }

  function allKeys () {
    // handle other characters
    if (self.in_buffer.length < self.input_buffer_max){
      self.input_log(self.in_buffer + String.fromCharCode(event.which));
    }
  }
};

// add a new command to the console
// name: name of the command
// desc: short description displayed by help command
// help: detailed help displayed when running help command_name
// callback: the function to run when the command is run
// flags:
// jsConsole.prototype.add_cmd = function (name, desc, help, callback, flags) {
jsConsole.prototype.add_cmd = function (cmdObject) {
  cmdObject = $.extend({
    name: '',
    desc: null,
    help: null,
    callback: null,
    flags: []
  }, cmdObject);

  // add the command to the command list and sort the commands alphabetically
  this.cmd_list.push(cmdObject);

  this.cmd_list.sort(function(a, b) {
    return (a.name < b.name) ? -1 : ((a.name > b.name) ? 1 : 0);
  });
};

// return the command object for the specified name
// returns 0 if the command is not found
jsConsole.prototype.get_cmd = function (cmd_name) {
  for (var i =0 ; i< this.cmd_list.length ; i++) {
    if (this.cmd_list[i].name === cmd_name) return this.cmd_list[i];
  }

  return 0;
};

// parses a string into the command and an array of arguments
// return object { cmd:"cmd_name", args:[args_array] }
jsConsole.prototype.parse_cmd = function (cmd_string) {
  // replace extra whitespace
  var parts = cmd_string.trim().replace(/\s+/g, " ").split(" ");
  var cmd = parts[0];
  var args = parts.length > 1 ? parts.slice(1, parts.length) : [];

  return { "cmd" : cmd, "args" : args };
};

// run the command by calling the command's callback function
jsConsole.prototype.run_cmd = function (cmd, args) {
  // find the command
  var cmd_obj = this.get_cmd(cmd);

  if (cmd_obj === 0) {
    this.log("Command not recognized : " + cmd + "\n");
  } else {
    // run the callback if provided
    if (typeof(cmd_obj.callback) === 'function') cmd_obj.callback.call(this, args);
  }
};

// print text to the console buffer
jsConsole.prototype.log = function (str) {
  // add the text to the div element and scroll to the top
  this.output_elm.append(str + "\n");
  this.content_elm.scrollTop(10000);
};

// used to write log text to a temporary buffer
// this will prevent the log from refreshing after each log command
// use this if you want to print out lots of log information
// and flush the buffer when done
jsConsole.prototype.log_buffer = function (str) {
  this.tmp_buffer += str;
};

// this dumps the log buffer to the log output
jsConsole.prototype.buffer_flush = function () {
  this.log(this.tmp_buffer);
  this.buffer_clear();
};

jsConsole.prototype.buffer_clear = function () {
  this.tmp_buffer = "";
};

// clear the output buffer of the console
jsConsole.prototype.log_clear = function () {
  this.output_elm.empty();
};

// print text to the input buffer
jsConsole.prototype.input_log = function (str) {
  this.in_buffer = str;
  this.input_elm.text(this.cmd_prompt + str);
};

// clear the input buffer
jsConsole.prototype.input_clear = function () {
  this.in_buffer = "";
  this.input_elm.html(this.cmd_prompt);
};

// add the command string to the command history
jsConsole.prototype.add_cmd_history = function (str) {
  this.cmd_history.unshift(str);

  if (this.cmd_history.length >= this.cmd_history_size)
    this.cmd_history.pop();
};

// reset the command history
jsConsole.prototype.clear_cmd_history = function () {
  this.cmd_history = [];
};

module.exports = function (opts) {
  // apply default options
  opts = $.extend({
    parent_elm: 'body',
    input_elm: '.console .input',
    output_elm: '.console .output',
    content_elm: '.console .content',
    cmd_prompt: '$>',
    commands: []
  }, opts || {});

  opts.commands = opts.commands.concat(defaultCommands());

  // instantiate
  var m = new jsConsole(opts);

  // add events
  m.bind_events();
  // clear the input so the prompt updates
  m.input_clear();

  m.log("Welcome.\nTo list commands, type \"help\"\n");

  // return the console object
  return m;
};


/*==========  private  ==========*/


function defaultCommands () {
  return [{
    name: 'help',
    desc: 'provides help information for commands',
    help: 'provides help information for commands\nUsage: help [command-name]',
    callback: helpCommand
  }, {
    name: 'exit',
    desc: 'exit the program',
    help: 'exit the program\nUsage: exit',
    callback: exitCommand
  }, {
    name: 'clear',
    desc: 'clears the command window',
    callback: function () {
      this.log_clear();
    }
  }];
}

function helpCommand (args) {
  var self = this;

  // if we don't have args, display command list
  if (args.length === 0) {
    // going to buffer the commands as an example
    this.buffer_clear();

    this.log_buffer("For more information on a specific command, type \"help command-name\"\n\n");
    this.cmd_list.forEach(function(cmd) {
      var flags = cmd.flags;

      // if the command is not hidden, display the command
      if (typeof(flags) !== "undefined" && flags.hidden === true) {
        // ...
      } else {
        // write to the temporary buffer
        self.log_buffer(cmd.name + "\t\t" + cmd.desc + "\n");
      }
    });

    // dump the buffer
    this.buffer_flush();
  } else {
    // display detailed help for command
    // get the command
    var cmd = this.get_cmd(args[0]);

    // if the command doesn't exist, display error message
    if (cmd === 0) {
      this.log("Could not display help info for specified command : " + args[0] + "\n");
    } else {
      if (cmd.help && typeof(cmd.help) === 'function') {
        // if the detailed help is a function, call the function
        cmd.help();
      } else {
        // just print out the help, or desc string
        this.log(cmd.name + ': ' + (cmd.help || cmd.desc) + '\n');
      }
    }
  }
}

function exitCommand () {
  this.$parent_elm.trigger('jsConsole.exit');
}
