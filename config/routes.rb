Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resource :session
  resources :passwords, param: :token
  resources :registrations, only: %i[new create]
  resources :invitations, only: %i[edit update], param: :token

  get "activity/mine"
  get "activity/feed"

  get "up" => "rails/health#show", as: :rails_health_check

  root "activity#mine"
end
