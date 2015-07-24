Timer = 
{	
	DEFAULT_COUNTDOWN_TIME:       30,
	TIMER_UPDATE_INTERVAL_IN_S:   0.03,
	currentTime:                  0,
	timerInterval:                null,
	timer:                        $('#timer'),

	startCountDown: function(seconds) {
		this.currentTime   = seconds || this.DEFAULT_COUNTDOWN_TIME;
		this.timerInterval = setInterval($.proxy(this.decrementTimer, this), this.TIMER_UPDATE_INTERVAL_IN_S * 1000);
	},

	decrementTimer: function() {
		this.currentTime -= this.TIMER_UPDATE_INTERVAL_IN_S;
		this.updateTimerText();
		this.updateTimeRunningOutClass();
		this.currentTime <= 0 && this.reset();
	},

	updateTimeRunningOutClass: function() {
		var isDangerous = this.currentTime < 11 && this.currentTime > 0;
		$('#timer').toggleClass('danger', isDangerous);
	},

	updateTimerText: function() {
		var minutes       = Math.floor(this.currentTime / 60),
			minutes_in_s  = minutes * 60,
			seconds       = Math.floor(this.currentTime - minutes_in_s),
			miliseconds   = (this.currentTime - minutes_in_s - seconds).toFixed(2);


		miliseconds = miliseconds.split('.')[1];
		this.timer.html(minutes + ':' + seconds + ':' + miliseconds);
	},

	reset: function() {
		clearInterval(this.timerInterval);
		this.currentTime = 0;
		this.updateTimerText();
		this.updateTimeRunningOutClass();
	}
}