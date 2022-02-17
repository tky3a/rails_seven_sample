Rails.application.routes.draw do
  # これで認証系のルーティングが作成される
  devise_for :users

  root to: "articles#index"
  resources :articles, only: [:index, :new, :create] do
    collection do
      get "search"
    end
    # ----------------- memo --------------------------------------
    # memberを使うと　/articles/:id/search　というurlでidが使える様になる
    # member do
    #   get 'search'
    # end
    # --------------------------------------------------------------
  end
  get "/:uid/articles/:id", to: "articles#show", as: :article
  get "/:uid/articles/edit/:id", to: "articles#edit", as: :edit_article
  patch "/:uid/articles/edit/:id", to: "articles#update", as: :update_article
  resources :users
  # --------------
  # resources :users, only: [:index, :show, :new, :create] do
  #   resources :articles, only: [:show]
  # end
  # --------------

  # namespace "/:user_uid", param: :uid do
  #   resources :articles, only: [:show]
  # end
  get "static_pages/help"
end
