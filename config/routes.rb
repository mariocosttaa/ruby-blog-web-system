  Rails.application.routes.draw do
    # PANEL ROUTES
    namespace :panel do
      # Dashboard
      get "dashboard", to: "dashboard#index", as: :dashboard_index

      # Categories (manuais, helpers já com panel_ prefix)
      get    "categories",       to: "categories#index",   as: :categories_index
      get    "categories/new",         to: "categories#new",     as: :new_category
      post   "categories/create",      to: "categories#create",  as: :create_category
      get    "categories/edit/:id",    to: "categories#edit",    as: :edit_category
      patch  "categories/update/:id",  to: "categories#update",  as: :update_category
      delete "categories/destroy/:id", to: "categories#destroy", as: :destroy_category
    end

    devise_for :users
    get "up" => "rails/health#show", as: :rails_health_check
  end
