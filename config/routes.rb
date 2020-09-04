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

  scope '/reports' do
    get :infected_percentage, controller: :reports
    get :healthy_percentage, controller: :reports
    get :lost_points, controller: :reports
    get :current_position, controller: :reports
    get :average_resources, controller: :reports
  end
end
