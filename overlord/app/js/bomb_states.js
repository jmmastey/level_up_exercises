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

	getInputDigits: function() {
		var input = '';
		$('#code-input').each(function() { input += $(this).val() });
		return input;
	},

	submitHandler: function() {
		var shouldGoNextState = this.currentState().inputHandler(this.getInputDigits());
		shouldGoNextState && this.goNextState();
	},

	goToState: function(fromStateIndex, toStateIndex) {
		var state     = this.states[toStateIndex];
		var lastState = this.states[fromStateIndex];
		lastState && lastState.onLeaveState && lastState.onLeaveState();
		$('#code-input-panel input').val('');
		$('#overlord').attr('class', state.className);
		state.onEnterState && state.onEnterState();
	},

	goNextState: function() { 
		this.goToState(this.currentStateIndex, this.incStateIndex());
	},

	states: 
	[
		{
			className:    'activation', 
			inputHandler: function() { return true },
			onEnterState: function() { Bomb.toggleLid(false); Timer.reset() }
		},

		{
			className:    'deactivation', 
			inputHandler: function() { return true }
		},

		{
			className:    'standby', 
			inputHandler: function() { return true }
		},

		{
			className:    'armed', 
			inputHandler: function() { return true },
			onEnterState: function() { Bomb.toggleLid(true); Timer.startCountDown(); }
		},

		{
			className:    'exploded',
			inputHandler: function() { return true },
			onEnterState: function() { Timer.stop() }
		}
	]
}


BombStates.goNextState();