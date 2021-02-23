Rails.application.routes.draw do
  default_url_options :host => ENV["BASE_URL"] || "localhost"

  namespace :api do
    namespace :user do
      delete "delete/:id", to: "sessions#delete"
      get :activate, param: :id, to: "sessions#activate"
      get :me, to: "sessions#me"
      post :sign_in, to: "sessions#sign_in"
      post :sign_up, to: "sessions#sign_up"
      post :social_sign_up, to: "sessions#social_sign_up"

      get 'oauth/callback', to: 'oauths#callback'
      get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
    end

    namespace :list do
      resources :categories, only: :index
      resources :levels, only: :index
      resources :media_sub_types, only: :index
      resources :media_types, only: :index
      resources :resources, only: :index
    end

    resources :contents
  end

  root 'welcome#index'
end
