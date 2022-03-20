Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: %i[index show] do
      resources :posts, only: %i[index show new create destroy] do
        resources :comments, only: %i[new create destroy]
        resources :likes, only: %i[new create]
      end
    end
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[new create]
    end
  end
  # Defines the root path route ("/")
  root 'users#index'
end
