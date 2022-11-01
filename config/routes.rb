Rails.application.routes.draw do
  get 'home/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      post "/new_driver" => "drivers#new_driver", :as => :new_driver
      post "/add_user" => "drivers#add_user", :as => :add_user
      get "/user_lists" => "drivers#user_lists", :as => :user_lists
      get "/overall_paylater_amount" => "transactions#overall_paylater_amount", :as => :overall_paylater_amount
      
      resources :drivers do
        post :add_new_cards
        get :card_details
        post "/transaction_histories" => "transactions#transaction_histories", :as => :transaction_histories
        post "/add_fuel" => "transactions#add_fuel", :as => :add_fuel
        post "/wallet_history" => "transactions#wallet_history", :as => :wallet_history
        post "/settle_transaction" => "transactions#settle_transaction", :as => :settle_transaction
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
end
