#= require superagent

class SignupSumo
  instance = null

  DEFAULT_BASE_ENDPOINT = "https://signupsumo.com/api/v1/"

  DEFAULT_NOTIFIER_ENDPOINT = DEFAULT_BASE_ENDPOINT + "signups"

  NOTIFIER_VERSION = "0.9.0"

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  DEFAULT_EMAIL_INPUT_SELECTOR = 'input[type="email"], input[type="text"]'

  @init: ->
    instance = new @ unless instance

    instance

  @setToken: (token) ->
    @init().token = token

  @send: (email) ->
    @init().send(email)

  constructor: ->
    @token = @getDataAttribute('data-token')
    @debug = @getDataAttribute('data-debug')
    @auto  = @getDataAttribute('data-auto') != "false"

    if @token and @auto
      @installListeners()

  forms: ->
    document.forms

  log: ->
    if @debug and console
      [].unshift.call(arguments, "[SignupSumo v#{NOTIFIER_VERSION}]")
      console.log.apply(console, arguments)

  getDataAttribute: (name) ->
    document.querySelector("script[#{name}]")?.getAttribute(name)

  installListeners: ->
    @log 'Installing listeners...'
    @installListener(form) for form in @forms()

  installListener: (form) ->
    @log 'Installing listener to fields in form', form
    for input in form.querySelectorAll(DEFAULT_EMAIL_INPUT_SELECTOR)
      @log 'Installing listener to input field', input
      input.addEventListener 'blur', (event) =>
        @handleBlur(event.target)
    form.addEventListener 'submit', (event) =>
      @handleSubmit(form)

  handleBlur: (field) ->
    cleanEmail = field.value.replace(/^\s+|\s+$/g, '')
    if @validateEmailFormat(cleanEmail)
      @send(cleanEmail).end()

  handleSubmit: (form) ->
    for input in form.querySelectorAll(DEFAULT_EMAIL_INPUT_SELECTOR)
      input.blur()

  send: (email) ->
    if @token
      endpoint = DEFAULT_NOTIFIER_ENDPOINT
      data =
        token: @token
        url: window.location.origin
        email: email

      return superagent
        .post(endpoint)
        .send(data)
    else
      throw 'Token required to send emails. Do `SignupSumo.setToken(TOKEN)` to set it'

  validateEmailFormat: (email) ->
    !!email.match(EMAIL_REGEX)

window.SignupSumo = SignupSumo

loadCompleted = ->
  SignupSumo.init()

if document.addEventListener
  document.addEventListener("DOMContentLoaded", loadCompleted, true)
else
  window.attachEvent("onload", loadCompleted)
