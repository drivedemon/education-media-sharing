Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      # root 'homepages#index', as: :authenticated_root
      root 'welcome#index'
    end

    # unauthenticated do
    #   root 'devise/sessions#new', as: :unauthenticated_root
    # end
  end
end
