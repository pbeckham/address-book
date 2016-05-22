Rails.application.routes.draw do
  root 'people#index'

  resources :organisations do
    resources :memberships, only: [:new, :create, :destroy]
  end
  resources :people

end
