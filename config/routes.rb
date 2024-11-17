Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :products, only: [ :index, :show, :new, :create, :edit, :update ]

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



  root "products#index"
end
