Rails.application.routes.draw do
  root to: 'tasks#index'
    
    #ログインフォーム
    get 'login', to: 'sessions#new'
    
    #ログイン処理を担当するアクション
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    #ユーザ登録用のフォーム
    get 'signup', to: 'users#new'
    resources :users, only: [:new, :create]
    resources :tasks
end
