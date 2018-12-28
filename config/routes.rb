Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions
  resources :patients

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
