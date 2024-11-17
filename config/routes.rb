Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
 end

  resources :products, only: [ :index, :show ]

  resources :carts, only: [ :show, :update, :destroy ] do
    member do
      patch :add_product
    end

    collection do
      patch :update, as: :update_carts
    end
  end

  resources :orders, only: [ :new, :create ]

  resource :profiles, only: [ :show, :edit, :update ]

  resources :admins, only: [ :index ] do
    patch :update_role, on: :member
  end

  namespace :admins do
    resources :products, only: [ :index, :new, :create, :edit, :update ]
    resources :users, only: [ :index, :edit, :update ]
  end


  root "products#index"
end
