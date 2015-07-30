Bomb = {
	toggleLid: function(isOpen) { 
		$('#briefcase-lid').toggleClass('open', isOpen); 
		$('.tank').toggleClass('show', isOpen); 
	},

	setActivationInputHandler: function(input, nextStateCallback) {
		Bomb.inputRequest(true, true, input, nextStateCallback);
	},

	setDeactivationInputHandler: function(input, nextStateCallback) {
		Bomb.inputRequest(false, true, input, nextStateCallback);
	},

	checkActivationInputHandler: function(input, nextStateCallback) {
		Bomb.inputRequest(true, false, input, nextStateCallback);
	},

	checkDeactivationInputHandler: function(input, nextStateCallback) {
		Bomb.inputRequest(false, false, input, function(codeStatus) {
			if (codeStatus.is_valid) {
				BombStates.goToState(BombStates.ACTIVATION)
			} else {
				CodePanel.clear();
				CodePanel.flashWarning();
				codeStatus.exceded_max_attempts && BombStates.goToState(BombStates.EXPLODED)
			}
		});
	},

	inputRequest: function(isActivation, isSetter, code, nextStateCallback) {
		var codeType    = isActivation ? 'activation' : 'deactivation',
			requestType = isSetter     ? 'set'        : 'check',
			requestUrl  = this.buildUrl([codeType, requestType, code]);

		$.post(requestUrl, nextStateCallback);
	},

	reset: function() {
		$.post(this.buildUrl(['bomb', 'reset']));
		this.toggleLid(false);
		Timer.reset();
	},

	arm: function() {
		this.toggleLid(true);
		Timer.startCountDown();
	},

	buildUrl: function(urlParts) {
		return '/' + urlParts.join('/');
	}
};