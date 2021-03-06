Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'games#index'
  resources :games, only: [:new, :show, :create, :update, :destroy] do
    resources :pieces, only: [:create, :show, :update]
  end
end
