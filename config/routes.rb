Rails.application.routes.draw do
  resources :flags
  apipie
  resources :resources
  resources :people do
    put :location, on: :member
  end
  post :trades, to: 'trades#trade'
  resources :inventories

  root 'apipie/apipies#index'
end
