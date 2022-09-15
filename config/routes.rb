Rails.application.routes.draw do
  
  devise_for :admin, skip: [:passwords], controllers: {
  registrations: "admin/registrations",
  sessions: "admin/sessions"
}

  devise_for :user, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
    devise_scope :user do
    post "user/guest_sign_in", to: "user/sessions#guest_sign_in"
    #コントローラのクラス名を揃える
    #階層が違った。サインイン等は上に
    end
  
    namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    end
  
    scope module: :user do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :users, only: [:index, :show, :edit, :update] do
 # いいね一覧表示
    member do
    get :favorites
    end
    end
    resources :genres, only: [:index]
    resources :ideas, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    resources :idea_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    get '/genre_ideas' => 'ideas#genre_ideas'
    end
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
