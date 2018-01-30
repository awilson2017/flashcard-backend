Rails.application.routes.draw do
  resources :flashcards
  resources :users

  resources :users do
    resources :flashcards
  end


  # login/logout resources
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout', as: 'logout'

  get 'google', to: 'googles#google', as:'google'
  get 'forvo', to: 'forvos#forvo', as: 'forvo'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
