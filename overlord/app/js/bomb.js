Bomb = {
	toggleLid: function(isOpen) { 
		$('#briefcase-lid').toggleClass('open', isOpen); 
		$('.tank').toggleClass('show', isOpen); 
	}
};