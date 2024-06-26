Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations',
                                      omniauth_callbacks: 'callbacks'}
  resources :events
  resources :event_joinings, only: [:create, :destroy]
  resources :invitations, only: [:index, :create] do
    member do
      post :accept
      post :reject
    end
  end
  resources :users, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # another way to define routes: get '/events/:id', to: 'events#show', as: 'custom_event'
  root "events#index"
end
