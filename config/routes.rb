Rails.application.routes.draw do
  namespace :api do
    namespace :user do
      post :sign_up, to: "sessions#sign_up"
      post :social_sign_up, to: "sessions#social_sign_up"
      get :activate, param: :id, to: "sessions#activate"
    end
  end
end
