Rails.application.routes.draw do
  get "home/index"
  get "animals/index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  # Routes pour les personnes
  resources :people, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  # Routes pour les animaux
  resources :animals, only: [:index]
end
