g.modalFocus = function() {
	//var self = g.modalFocus;
	
	this.modalWindow = $('.modal');
	this.modalItem = $('.modal_signup');

	this.showModal = function showModal() {
		self.modalWindow.addClass('modal--active');
		self.modalItem.addClass('modal_signup--active');
	};

	this.closeModal = function closeModal() {
		self.modalWindow.removeClass('modal--active');
		self.modalItem.removeClass('modal_signup--active');
	};

	$(document).on('click', '[data-js="open-modal"]', function(e) {
		self.showModal();
		e.preventDefault();
	});

	$(document).on('click', '[data-js="close-modal"]', function(e) {
		self.closeModal();
		e.preventDefault();
	});
}