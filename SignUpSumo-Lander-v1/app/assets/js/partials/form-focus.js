g.formFocus = function() {
	//var self = g.formFocus;
	this.form = $('.subscribe__form form');

	// Check for a input[type="email"], and if that's not there assume
	// it's an input[type="text"]
	this.formField = this.form.find('input[type="email"]') || this.form.find('input[type="text"]');

	this.scrollToForm = function scrollToForm() {
		$('html, body').animate({
			'scrollTop': self.form.offset().top
		}, 500);
	};

	this.focusFormField = function focusFormField() {
		this.formField.focus();
	};

	$(document).on('click', '[data-js="focus-on-form"]', function(e) {
		self.scrollToForm();
		self.focusFormField();
		e.preventDefault();
	});
}