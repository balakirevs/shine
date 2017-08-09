Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#index'
  get 'customers/ng',                to: 'customers#ng'
  get 'customers/ng/*angular_route', to: 'customers#ng'
  resources :customers, only: %i[index show update]
  get 'bootstrap_mockups', to: 'bootstrap_mockups#index'
  get 'credit_card_info/:id', to: 'fake_payment_processor#show'
end
