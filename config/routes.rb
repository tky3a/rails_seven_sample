Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles, only: [:index, :new, :create]
  get '/:uid/articles/:id', to: 'articles#show', as: :article

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
