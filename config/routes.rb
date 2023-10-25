Rails.application.routes.draw do
  devise_for :users

  root to: "articles#home"

  resources :articles do
    collection do
      post 'search'
      get 'analytics'
    end
  end
  
  resources :users, only: [] do
    member do
      get 'search_queries'
    end
  end

end
