Rails.application.routes.draw do
  root 'welcome#index'

  get ':api_key/signupsumo.:format', to: 'scripts#show', api_key: /[0-9a-f]{32}/i, format: :js

  get 'scripts/test', to: 'scripts#test'
end
