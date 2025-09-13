require 'sidekiq/web'
Rails.application.routes.draw do

  # get "report/index"
  # get "report/create"
  # get "report/new"
  # get "report/show"
  namespace :api do
    namespace :v1 do 
      resources :projects
  end
end



mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

devise_for :users, controllers: { sessions: 'users/sessions' }

# devise_for :users ,controller: {sessions: 'users/sessions'}
resources :projects


resources :bugs do 
  member do 
    patch :assign
    patch :resolve
  end
end
resources :reports
  root "projects#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
