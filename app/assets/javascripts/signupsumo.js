(function() {
  var loadCompleted;

  this.SignupSumo = (function() {
    var DEFAULT_BASE_ENDPOINT, DEFAULT_EMAIL_INPUT_SELECTOR, DEFAULT_NOTIFIER_ENDPOINT, EMAIL_REGEX, NOTIFIER_VERSION;

    DEFAULT_BASE_ENDPOINT = "http://signupsumo.com/api/v1/";

    DEFAULT_NOTIFIER_ENDPOINT = DEFAULT_BASE_ENDPOINT + "newsignup";

    NOTIFIER_VERSION = "0.9.0";

    EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;

    DEFAULT_EMAIL_INPUT_SELECTOR = 'input[type="email"], input[type="text"]';

    function SignupSumo() {
      this.apiKey = document.querySelector('script[data-token]').getAttribute('data-token');
      this.debug = false;
      this.installListeners();
    }

    SignupSumo.prototype.forms = function() {
      return document.forms;
    };

    SignupSumo.prototype.log = function() {
      if (this.debug && console) {
        [].unshift.call(arguments, "[SignupSumo v" + NOTIFIER_VERSION + "]");
        return console.log.apply(console, arguments);
      }
    };

    SignupSumo.prototype.installListeners = function() {
      var form, _i, _len, _ref, _results;
      this.log('Installing listeners...');
      _ref = this.forms();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        form = _ref[_i];
        _results.push(this.installListener(form));
      }
      return _results;
    };

    SignupSumo.prototype.installListener = function(form) {
      var input, _i, _len, _ref, _results;
      this.log('Installing listener to fields in form', form);
      _ref = form.querySelectorAll(DEFAULT_EMAIL_INPUT_SELECTOR);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        input = _ref[_i];
        this.log('Installing listener to input field', input);
        _results.push(input.addEventListener('blur', (function(_this) {
          return function(event) {
            return _this.handleBlur(event.target);
          };
        })(this)));
      }
      return _results;
    };

    SignupSumo.prototype.handleBlur = function(field) {
      var cleanEmail;
      cleanEmail = field.value.replace(/^\s+|\s+$/g, '');
      if (this.validateEmailFormat(cleanEmail)) {
        return this.submitEmail(cleanEmail);
      }
    };

    SignupSumo.prototype.submitEmail = function(email) {
      var endpoint;
      endpoint = DEFAULT_NOTIFIER_ENDPOINT;
      return $.ajax({
        url: endpoint,
        type: 'POST',
        data: {
          token: this.apiKey,
          url: window.location.origin,
          email: email
        }
      });
    };

    SignupSumo.prototype.validateEmailFormat = function(email) {
      if (email.match(EMAIL_REGEX)) {
        return true;
      } else {
        return false;
      }
    };

    return SignupSumo;

  })();

  loadCompleted = function() {
    return new SignupSumo;
  };

  if (document.addEventListener) {
    document.addEventListener("DOMContentLoaded", loadCompleted, true);
  } else {
    window.attachEvent("onload", loadCompleted);
  }

}).call(this);
