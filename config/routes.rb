Rails.application.routes.draw do


  scope module: :user do
    root "homes#top"
    get 'about' => 'homes#about'
     get "/search", to: "searches#search"
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
      resources :users, only: [:index,:show,:edit,:update]do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
devise_for :user,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

end
