require 'sidekiq/web'

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

    resource :subscription,
      only: [:show, :create]

    get '/docs' => 'pages#docs', as: :docs
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

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq',
      as: :production_sidekiq
  end

  if Rails.env.development?
    get '/test',
      to: 'pages#test'

    mount Sidekiq::Web => '/sidekiq',
      as: :development_sidekiq
  end
end
