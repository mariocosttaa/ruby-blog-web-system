  Rails.application.routes.draw do
    # PANEL ROUTES
    namespace :panel do
      # Dashboard
      get "dashboard", to: "dashboard#index", as: :dashboard_index
      get "", to: redirect("/panel/dashboard")

      get "posts",                to: "posts#index",   as: :posts_index
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

      # Comments
      get    "comments",               to: "comments#index",     as: :comments_index
      patch  "comments/update/:id",    to: "comments#update",    as: :update_comment
      delete "comments/destroy/:id",   to: "comments#destroy",   as: :destroy_comment
    end

    # PUBLIC ROUTES
    get "/", to: "public/home#index", as: :public_home_index
    get "/articles", to: "public/articles#index", as: :public_articles_index
    get "/article/:slug", to: "public/articles#show", as: :public_article_show
    patch "/article/comment/:slug", to: "public/articles#create_comment", as: :public_article_comment

    get "/tags", to: "public/tags#index", as: :public_tags_index
    get "/tag/:slug", to: "public/tags#show", as: :public_tag_show

    get "/categories", to: "public/categories#index", as: :public_categories_index
    get "/category/:slug", to: "public/categories#show", as: :public_category_show

    get "/search", to: "public/search#show", as: :public_search_index
    get "/search/:query", to: "public/search#show", as: :public_search_show

    get "/privacy-policy", to: "public/statics#privacy_policy", as: :public_privacy_policy_index
    get "/terms-of-use", to: "public/statics#terms_of_use", as: :public_terms_of_use_index


    root "public/home#index"

    devise_for :users, path: 'auth', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register',
      password: 'recovery',
      confirmation: 'verification',
      unlock: 'unlock'
    }
    get "up" => "rails/health#show", as: :rails_health_check
  end
