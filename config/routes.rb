Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "home#index"

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    resources :wishlists, only: [ :create, :destroy ]
  end
  resources :properties, only: [ :show ] do
    resources :bookings, only: [ :new ]
  end

  resources :booking_payments, only: [ :create ]

  get "booking_payments/success", to: "booking_payments#success"
end
