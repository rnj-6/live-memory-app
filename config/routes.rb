Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # マイページ
  get "users/show", to: "users#show"
  get "users/edit", to: "users#edit"
  patch "users/show", to: "users#update"

  
  # 参戦予定 showのみ除外
  resources :live_events, except: :show do
    resource :live_log, except: [:index, :show]
  end

  # 会場検索
  post "live_events/venue_search", to: "live_events#venue_search"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
end
