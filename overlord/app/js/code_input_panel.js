(function() {
	$('#code-input-panel input').on('focus blur', toggleHiddenChars).on('keyup', skipToNextInput);
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