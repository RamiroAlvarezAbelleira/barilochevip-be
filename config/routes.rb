Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :users, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show create update]
      resources :equipos, only: %i[index show create update destroy]
      resources :categories, only: %i[index show create update destroy]
      resources :marcas, only: %i[index show create update destroy]
      resources :bookings, only: %i[index show create update destroy]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
