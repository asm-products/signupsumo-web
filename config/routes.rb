Rails.application.routes.draw do

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  root 'welcome#index'

  get ':api_key/signupsumo.:format', to: 'scripts#show', api_key: /[0-9a-f]{32}/i, format: :js

  get 'scripts/test', to: 'scripts#test'

  scope '/api' do 
    scope '/v1' do
      get '/newsignup', to: 'register#create'
    end
  end

end
