Rails.application.routes.draw do
  scope module: :public do
    devise_for :users

    # homes
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
    get 'homes/about' => 'homes#about'

    # users
    get 'users/mypage' => 'users#mypage', as: :mypage
    get 'users/myprofile/edit' => 'users#edit', as: :edit
    get 'users/infomation' => 'users#show', as: :infomation
    patch 'users/infomation' => 'users#update', as: :update
    delete 'users/withdraw' => 'users#withdraw', as: :withdraw



  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
