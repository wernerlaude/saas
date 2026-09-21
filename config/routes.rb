Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :registrations, only: %i[new create]

  get "activity/mine"
  get "activity/feed"

  get "up" => "rails/health#show", as: :rails_health_check

  root "activity#mine"
end
