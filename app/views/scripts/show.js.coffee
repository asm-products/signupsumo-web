class @SignupSumo
    DEFAULT_BASE_ENDPOINT = "http://api.signupsumo.com/"

    DEFAULT_NOTIFIER_ENDPOINT = DEFAULT_BASE_ENDPOINT + "signups"

    NOTIFIER_VERSION = "0.9.0"

    EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

    DEFAULT_EMAIL_INPUT_SELECTOR = 'input[type="text"]'

    constructor: ->
      @apiKey = document.querySelector('script[data-token]').getAttribute('data-token')
      @debug = true
      @installListeners()

    forms: ->
      document.forms

    log: ->
      if @debug and console
        [].unshift.call(arguments, "[SignupSumo v#{NOTIFIER_VERSION}]")
        console.log.apply(console, arguments)

    installListeners: ->
      @log 'Installing listeners...'
      @installListener(form) for form in @forms()

    installListener: (form) ->
      @log 'Installing listener to form', form
      form.addEventListener 'submit', (event) =>
        @handleSubmit(event.target)

    handleSubmit: (form) ->
      emails = @fetchEmails(form)
      if emails.length > 0
        @submitEmails(emails)

    submitEmails: (emails) ->
      endpoint = DEFAULT_NOTIFIER_ENDPOINT
      @log('Submitting', emails, 'to', endpoint, 'using API KEY', @apiKey)

    fetchEmails: (form) ->
      emails = []
      for input in form.querySelectorAll(DEFAULT_EMAIL_INPUT_SELECTOR)
        cleanEmail = input.value.replace(/^\s+|\s+$/g, '')
        if @validateEmailFormat(cleanEmail)
          emails.push cleanEmail

      emails

    validateEmailFormat: (email) ->
      if email.match(EMAIL_REGEX)
        true
      else
        false

loadCompleted = ->
  new SignupSumo

if document.addEventListener
  document.addEventListener("DOMContentLoaded", loadCompleted, true)
else
  window.attachEvent("onload", loadCompleted)
