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



  root "products#index"
end
