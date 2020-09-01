Rails.application.routes.draw do
  apipie
  resources :resources
  resources :people
  resources :inventories
end
