Rails.application.routes.draw do

  # Root route for homepage ('/') of site
  root 'home#index'

  # Resource routes for Users and Shifts
  resources :users do
    resources :shifts, as: :shifts
  end
  resources :shifts

  # Routes for login and logout
  resource :session, only: [:new, :create, :destroy]
  
  # Routes for versioned API endpoints
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :shifts, only: [:index]
      end
      resources :sessions, only: [:create, :destroy]
    end
  end

end
