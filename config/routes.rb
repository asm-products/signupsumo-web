Rails.application.routes.draw do

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'signin',
      sign_out: 'signout',
      sign_up: 'signup'
    }

  authenticated :user do
    root :to => "websites#index", as: :authenticated_root
  end

  root 'static#index'

  get ':api_key/signupsumo.:format', to: 'scripts#show', api_key: /[0-9a-f]{32}/i, format: :js

  get 'scripts/test', to: 'scripts#test'

  resources 'websites' do
    get 'registers', to: 'registers#index', on: :member
  end
  
  scope '/api' do 
    scope '/v1' do
      get '/newsignup', to: 'registers#create'
    end
  end

end
