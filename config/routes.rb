Rails.application.routes.draw do
  resources :users
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  post "/accounts/sort", to: "account_templates#sort"
  post "/records/sort", to: "records#sort"
  resources :accounts
  resources :account_templates
  resources :tasks do
    resources :records, shallow: true do
      resources :entries
    end
    get "/accounts/:account_number", to: "accounts#show_by_number"
  end
  root to: "tasks#show"

  get "/observe", to: "observers#observe"
  # gem
  patch "/editable", to: "editables#update"
end
