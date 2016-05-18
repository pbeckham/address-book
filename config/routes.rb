Rails.application.routes.draw do
  root 'people#index'

  resources :organisations do
    resources :memberships, only: [:create, :destroy]
  end
  resources :people

end
