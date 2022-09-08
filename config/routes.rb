Rails.application.routes.draw do
  
  devise_for :admin, skip: [:passwords], controllers: {
  registrations: "admin/registrations",
  sessions: "admin/sessions"
}

  devise_for :user, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
  
    namespace :admin do
    root to: "homes#top"
    resources :publics, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    end
  
    scope module: :user do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/user/:id' => 'users#show'
    get '/my_page' => 'users#my_page', as: 'user_my_page'
    get '/user/information/edit' => 'users#edit'
    patch '/user/information' => 'users#update'
    resources :ideas, only: [:new, :index, :show, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :index, :show, :create]
    end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
