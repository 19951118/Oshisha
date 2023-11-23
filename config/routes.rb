Rails.application.routes.draw do
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  scope module: :user do
    root "homes#top"
    get 'about' => 'homes#about'
    get "/search", to: "searches#search"
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
      resources :users, only: [:index, :show, :edit, :update, :destroy]do
        member do
          get :favorites
        end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  
  namespace :admin do
    root 'homes#top'
    get "/search", to: "searches#search"
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts do
      resources :post_comments
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
