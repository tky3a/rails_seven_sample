Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles, only: [:index, :new, :create]
  # あとで使う
  # namespace :articles do
  #   resources :photos
  # end
  # post 'photos', to: 'photos#create'
  # get 'photos/new', to: 'photos#new', as: 'new_photo'
  # get 'photos/:id/edit', to: 'photos#edit', as: 'edit_photo'
  # get 'photos/:id', to: 'photos#show', as: 'photo'
  # patch 'photos/:id', to: 'photos#update'
  # put 'photos/:id', to: 'photos#update'
  # delete 'photos/:id', to: 'photos#destroy'

  get 'static_pages/help'
end
