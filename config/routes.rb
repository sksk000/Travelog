Rails.application.routes.draw do
  scope module: :public do
    devise_for :users

    # homes
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about

    # users
    get 'mypage' => 'users#mypage', as: :mypage
    post 'users/myprofile/edit' => 'users#edit', as: :edit
    patch 'users/infomation' => 'users#update', as: :users_update_infomation

    resource :users, only:[] do
      get :infomation, on: :collection
      delete :withdraw, on: :collection
    end

    # post
    resources :posts, only:[:new, :index, :show, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
