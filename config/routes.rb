Rails.application.routes.draw do
  resources :flags
  apipie
  resources :resources
  resources :people do
    put :location, on: :member
  end
  resources :inventories
end
