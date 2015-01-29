// Create the global g object which will store all our code.
var g = g || {};

// Create an array of the partials we're including in the g object
// 		Ensure that these are added on separate lines so as to allow for
// 		easier version controlling when multiple users are collaborating
// 		on the JS simultaneously.
g.partials = [
	'formFocus'
];

// This _init function is the function which kicks everything off when
// the document is ready.
//
// It loops through all the items in the array above, and runs that
// particular function.
//
// If we had 3 items in that array, say 'classes', 'sizing' and 'slider'
// then this function would run g.classes(), g.sizing() and g.slider();
g._init = function() {
	var self = this;
	for (var i = 0; i < this.partials.length; i++) {
		var partial = g[this.partials[i]];
		partial();
	}
};
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
$(function() {
	// This is all we need in our main.js file - isn't it neat :)
	g._init();
});
