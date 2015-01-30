Rails.application.routes.draw do
  devise_for :users,
    path_names: {
      sign_in: 'signin',
      sign_out: 'signout',
      sign_up: 'signup'
    }

  authenticated :user do
    root to: redirect('/dashboard'),
      as: :authenticated_root

    resources :dashboard,
      only: [:index]
  end

  root 'pages#home'

  resource :styleguide,
    only: [:show]

  scope '/api' do
    scope '/v1' do
      # TODO: change this to be more restful
      match '/signups' => 'signups#create', via: [:get, :post]
    end
  end

  if Rails.env.development?
    get '/test',
      to: 'pages#test'
  end
end
