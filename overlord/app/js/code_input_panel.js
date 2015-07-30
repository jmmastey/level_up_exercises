CodePanel = {
	inputs: $('#code-input-panel input'),
	WARNING_CLASS: 'warning',

	flashWarning: function() {
		self = this
		clearTimeout(this.warningTimer);
		this.inputs.addClass(this.WARNING_CLASS);
		this.warningTimer = setTimeout(function() {
			self.inputs.removeClass(self.WARNING_CLASS);
		}, 500);
	},

	clear: function() {
		this.inputs.val('');
	},

	getInputDigits: function() {
		var input = '';
		this.inputs.each(function() { input += $(this).val() });
		return input;
	},
};

(function() {
	CodePanel.inputs.on('focus blur', toggleHiddenChars).on('keyup', skipToNextInput);
	$('#input-submit').on('click', function() { BombStates.submitHandler() });

	function toggleHiddenChars(event) {
		var inputType = event.type == 'blur' ? 'password' : 'text';
		$(this).attr('type', inputType);
	}

	function skipToNextInput() {
		var validEntry = $(this).val().length == 1;
		validEntry && $(this).next('input, button').focus();
	}
})();
