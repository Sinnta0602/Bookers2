Rails.application.routes.draw do
  
  
  root 'books#top'
  get '/home/about' => 'books#about'
  
  # MEMO: devise(rails g devise MODEL)で自動生成されたルーティング。
  #                    Prefix Verb   URI Pattern   Controller#Action
  #       new_user_session GET    /users/sign_in(.:format)    devise/sessions#new
  # rails g devise:controllers users でusersフォルダいかにdeviseのcontrollerを作ったので、それを参照するように変更
  # https://github.com/heartcombo/devise/blob/master/lib/devise/rails/routes.rb#L133
  devise_for :users,
    path: "",
    path_names: {
      sign_in: "users/sign_in",
      sign_up: "users/sign_up",
      sign_out: "logout"
    },
    controllers: {
      # フォルダ名/コントローラ名と対応。
      registrations: "users/registrations",
      sessions: "users/sessions",
    }

  resources :books
  resources :users, only: [:index, :show, :edit, :update]
end
