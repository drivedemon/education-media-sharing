Rails.application.routes.draw do
  namespace :api do
    namespace :user do
      get :activate, param: :id, to: "sessions#activate"
      get :me, to: "sessions#me"
      post :sign_in, to: "sessions#sign_in"
      post :sign_up, to: "sessions#sign_up"
      post :social_sign_up, to: "sessions#social_sign_up"
    end
  end
end
