Rails.application.routes.draw do
  namespace :public do
    get 'maps/show'
  end
   devise_for :admin,controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    resources :users, only:[:index,:show,:destroy]
    resources :posts, only:[:index,:show,:destroy]
    resources :comments, only:[:destroy]
  end

  scope module: :public do
    devise_for :users

    # homes
    root to: 'posts#index'
    get 'homes/about', to: 'homes#about', as: :about

    # users
    get 'mypage/:id' => 'users#mypage', as: :mypage
    get 'mypage/:id/edit' => 'users#edit', as: :edit
    get 'mypage/:id/place' => 'users#mypage_place', as: :mypage_place
    patch 'users/infomation' => 'users#update', as: :users_update_infomation
    get 'mypage/:id/post_index' => 'users#post_index', as: :post_index

    resource :users, only:[] do
      get :infomation, on: :collection
      delete :withdraw, on: :collection
    end

    # post
    # resources :posts, only:[:new, :index, :show, :create, :edit, :update, :destroy] ,defaults: { format: 'json' } do
    resources :posts, only:[:new, :index, :show, :create, :edit, :update, :destroy] do
      # comment
      resources :comments, only:[:create,:destroy]
      resource :places, only:[:new, :create, :update, :edit ]
      resource :tags, only:[:create]

      member do
        patch :publish
      end
    end


    # search
    get 'search/result' => 'searches#search'

    resources :maps, only: [:show]

    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
