$.fn.random = function() {
	return this.eq(Math.floor(Math.random() * this.length));
};

(function() {
	var WRONG_CLASS   = 'wrong',
	    CORRECT_CLASS = 'correct';

	initRandomCorrectWire();
	$('.wire').on('click', cutWire);          

	function initRandomCorrectWire() {
		var correctWire = $('.wire').addClass(WRONG_CLASS).random();
		correctWire.removeClass(WRONG_CLASS).addClass(CORRECT_CLASS);
	}

	function cutWire(event) {
		var wire = $(event.currentTarget)
		var nextStateIndex = wire.hasClass(CORRECT_CLASS) ? 0 : 4;
		BombStates.goToState(nextStateIndex);
	}
})();