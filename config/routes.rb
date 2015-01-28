Rails.application.routes.draw do
  devise_for :users,
    path_names: {
      sign_in: 'signin',
      sign_out: 'signout',
      sign_up: 'signup'
    }

  authenticated :user do
    root :to => "pages#config", as: :authenticated_root
  end

  get '/setup' => 'pages#setup'

  get '/:api_key/signupsumo.:format', to: 'scripts#show', api_key: /[0-9a-f]{32}/i, format: :js
  get '/scripts/test', to: 'scripts#test'

  root 'static#index'
end
