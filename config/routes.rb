Rails.application.routes.draw do
  #---------------- divise routiong start -------------------------------
  # これで認証系のルーティングが作成される
  devise_for :users
  # registrationsとsessionsのルーティングのパスを修正(エラーでなければそのままでよさそう。。。)
  devise_scope :user do
    get "/users/new", to: "devise/registrations#new"
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  #---------------- divise routiong end -------------------------------

  #---------------- user routiong start -------------------------------
  get "/:uid", to: "users#show", as: :user
  #---------------- user routiong end -------------------------------

  #---------------- article routiong start -------------------------------
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
  #---------------- article routiong end -------------------------------

  # namespace "/:user_uid", param: :uid do
  #   resources :articles, only: [:show]
  # end
  get "static_pages/help"
end
