Rails.application.routes.draw do
  get "public/home"
  resource :dashboard, only: :show, controller: :dashboard
  devise_for :users

  resources :shifts, only: [] do
    collection do
      get :mine, as: :my
    end
  end

  resources :users do
    resources :shifts do
      member do
        patch :acknowledge
        patch :add_employee_note
      end
    end
  end

  root "public#home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
