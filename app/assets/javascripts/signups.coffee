#= require superagent

class @SignupSumo
  DEFAULT_BASE_ENDPOINT = "http://signupsumo.com/api/v1/"

  DEFAULT_NOTIFIER_ENDPOINT = DEFAULT_BASE_ENDPOINT + "signups"

  NOTIFIER_VERSION = "0.9.0"

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  DEFAULT_EMAIL_INPUT_SELECTOR = 'input[type="email"], input[type="text"]'

  constructor: ->
    @token = document.querySelector('script[data-token]').getAttribute('data-token')
    @debug = document.querySelector('script[data-debug]').getAttribute('data-debug')
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
    @log 'Installing listener to fields in form', form
    for input in form.querySelectorAll(DEFAULT_EMAIL_INPUT_SELECTOR)
      @log 'Installing listener to input field', input
      input.addEventListener 'blur', (event) =>
        @handleBlur(event.target)

  handleBlur: (field) ->
    cleanEmail = field.value.replace(/^\s+|\s+$/g, '')
    if @validateEmailFormat(cleanEmail)
      @submitEmail(cleanEmail)

  submitEmail: (email) ->
    endpoint = DEFAULT_NOTIFIER_ENDPOINT
    data =
      token: @token
      url: window.location.origin
      email: email

    superagent
      .post(endpoint)
      .send(data)

  validateEmailFormat: (email) ->
    !!email.match(EMAIL_REGEX)

loadCompleted = ->
  new SignupSumo

if document.addEventListener
  document.addEventListener("DOMContentLoaded", loadCompleted, true)
else
  window.attachEvent("onload", loadCompleted)
