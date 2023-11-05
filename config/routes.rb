Rails.application.routes.draw do
  
  
  scope module: :user do
    root "homes#top"
    get 'about' => 'homes#about'
    get 'user' => 'users#show'
    get 'users' => 'users#index'
    get 'user/edit' => 'users#edit'

    resources :posts
  end
  
devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

end
