Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles, only: [:index, :new, :create]
  get '/:uid/articles/:id', to: 'articles#show', as: :article
  get '/:uid/articles/edit/:id', to: 'articles#edit', as: :edit_article
  patch '/:uid/articles/edit/:id', to: 'articles#update', as: :update_article
  resources :users
  # --------------
  # resources :users, only: [:index, :show, :new, :create] do
  #   resources :articles, only: [:show] 
  # end
  # --------------

  # namespace "/:user_uid", param: :uid do
  #   resources :articles, only: [:show] 
  # end
  get 'static_pages/help'
end
