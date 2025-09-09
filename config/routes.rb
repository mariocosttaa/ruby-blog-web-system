  Rails.application.routes.draw do
    # PANEL ROUTES
    namespace :panel do
      # Dashboard
      get "dashboard", to: "dashboard#index", as: :dashboard_index

      get "posts",          to: "posts#index",   as: :posts_index
      get "posts/new",            to: "posts#new",     as: :new_post
      post "posts/create",        to: "posts#create",  as: :create_post
      get "posts/edit/:id",       to: "posts#edit",    as: :edit_post
      patch "posts/update/:id",   to: "posts#update",  as: :update_post
      delete "posts/destroy/:id", to: "posts#destroy", as: :destroy_post

      get "tags",                to: "tags#index",   as: :tags_index
      get "tags/new",            to: "tags#new",     as: :new_tag
      post "tags/create",        to: "tags#create",  as: :create_tag
      get "tags/edit/:id",       to: "tags#edit",    as: :edit_tag
      patch "tags/update/:id",   to: "tags#update",  as: :update_tag
      delete "tags/destroy/:id", to: "tags#destroy", as: :destroy_tag

      # Categories (manuais, helpers já com panel_ prefix)
      get    "categories",             to: "categories#index",   as: :categories_index
      get    "categories/new",         to: "categories#new",     as: :new_category
      post   "categories/create",      to: "categories#create",  as: :create_category
      get    "categories/edit/:id",    to: "categories#edit",    as: :edit_category
      patch  "categories/update/:id",  to: "categories#update",  as: :update_category
      delete "categories/destroy/:id", to: "categories#destroy", as: :destroy_category
    end

    devise_for :users
    get "up" => "rails/health#show", as: :rails_health_check
  end
