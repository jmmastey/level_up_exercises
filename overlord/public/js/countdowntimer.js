function mod(n, m) {
    return ((n % m) + m) % m;
}

function CountdownTimer (t, s, ms, hidden) {
    var self = this;
    self.t = $(t);
    self.s = $(s);
    self.ms = $(ms);
    self.hidden = $(hidden);
    self.started = false;
    self.stopped = true;
    self.timer_intervals = [];

    self.get_time = function () {
        return self.s.html() + ':' + self.ms.html();
    };

    self.get_seconds = function () {
      return parseInt(self.s.html());
    }

    self.get_milliseconds = function () {
      return parseInt(self.ms.html());
    }

    self.maybe_prepend_zero = function (s) {
        return (s < 10) ? "0" + s.toString() : s.toString();
    };

    self.update_seconds = function () {
        var s = parseInt($(self.s).html());
        if (s !== 0)
            $(self.s).html(self.maybe_prepend_zero(s - 1));
    };

    self.update_milliseconds = function () {
        var ms = parseInt($(self.ms).html());
        ms = mod(ms - 1, 100);
        $(self.ms).html(self.maybe_prepend_zero(ms));
    };

    self.update_hidden = function () {
        $(self.hidden).val(self.get_time());
        $(self.hidden).trigger('change');
    }

    self.start_countdown = function () {
        if (self.started === true) return;
        self.started = true;
        self.stopped = false;
        self.timer_intervals.push(setInterval(self.update_timer, 10));
        self.timer_intervals.push(setInterval(self.blink, 300));
    };

    self.set_time = function (s, ms) {
        $(self.s).html(self.maybe_prepend_zero(s));
        $(self.ms).html(self.maybe_prepend_zero(ms));
    }

    self.stop_countdown = function () {
        for (var i = 0; i <= self.timer_intervals.length; i++) {
            clearInterval(self.timer_intervals[i]);
        }
        $(self.t).removeClass("blink blink-red");
        self.stopped = true;
    }

    self.update_timer = function () {
        if (self.stopped || !self.started) return;
        self.update_hidden();

        if ($(self.ms).html() == 0) {
          self.update_seconds();
        }
        if ($(self.s).html() == 0 || $(self.s).html() == 0) {
          self.stop_countdown();
          return;
        }
        self.update_milliseconds();
    };

    self.blink = function () {
        var blink = "blink";
        if (self.get_seconds() < 10)
            blink += "-red";
        if (self.t.hasClass(blink)) {
            self.t.removeClass(blink);
        } else {
            self.t.addClass(blink);
        }
    }
}
