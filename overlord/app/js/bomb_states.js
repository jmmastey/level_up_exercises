BombStates =  
{
	currentStateIndex: -1,

	incStateIndex: function()  {
		(++this.currentStateIndex >= this.states.length) && (this.currentStateIndex = 0);
		return this.currentStateIndex;
	},

	currentState: function() { 
		return this.states[this.currentStateIndex] ;
	},

	submitHandler: function() {
		this.currentState().inputHandler(CodePanel.getInputDigits(), function(codeStatus) {
			if (codeStatus.is_valid) {
				BombStates.goNextState();
			} else {
				CodePanel.clear();
				CodePanel.flashWarning();
			}
		});
	},

	goToState: function(toStateIndex) {
		var state     = this.states[toStateIndex];
		var lastState = this.states[this.currentStateIndex];
		lastState && lastState.onLeaveState && lastState.onLeaveState();
		$('#code-input-panel input').val('');
		$('#overlord').attr('class', state.className);
		state.onEnterState && state.onEnterState();
		this.currentStateIndex = toStateIndex;
	},

	goNextState: function() { 
		this.goToState(this.incStateIndex());
	},

	ACTIVATION:   0,
	DEACTIVATION: 1,
	STANDBY:      2,
	ARMED:        3,
	EXPLODED:     4,

	states: 
	[
		{
			className:    'activation',
			inputHandler: Bomb.setActivationInputHandler,
			onEnterState: function() {  Bomb.reset() }
		},

		{
			className:    'deactivation', 
			inputHandler: Bomb.setDeactivationInputHandler
		},

		{
			className:    'standby', 
			inputHandler: Bomb.checkActivationInputHandler
		},

		{
			className:    'armed', 
			inputHandler: Bomb.checkDeactivationInputHandler,
			onEnterState: function() { Bomb.arm() }
		},

		{
			className:    'exploded',
			inputHandler: function() { return true },
			onEnterState: function() { Timer.stop() }
		}
	]
}


BombStates.goNextState(BombStates.ACTIVATION);