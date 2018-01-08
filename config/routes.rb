Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "posts#index"
  resources :posts, only: [:new, :create, :index, :destroy, :show, :edit, :update] do
  	get :like_users, on: :member
  end
  resources :categories, only: [:new, :create, :index, :destroy]
  post 'posts/:id/like', to: 'posts#like', as: :like_post
end
