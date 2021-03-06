Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :lists do
    resources :contacts
  end

  post 'auth/login', to: 'authentication#authenticate'
  get 'auth', to: 'authentication#logged'
  delete 'auth/logout', to: 'authentication#logout'
  post 'users/signup', to: 'users#create'
end
