Rails.application.routes.draw do
  root 'frontend#index'

  resource :frontend, controller: :frontend

  namespace :api do
    resources :organisations do
      resource :contact_details
      resources :memberships, only: [:create, :destroy]
    end
    resources :people do
      resource :contact_details
    end
  end

end
