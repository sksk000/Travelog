Rails.application.routes.draw do
  scope module: :public do
    devise_for :users

    # homes
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about

    # users
    get 'mypage' => 'users#mypage', as: :mypage
    post 'users/myprofile/edit' => 'users#edit', as: :edit

    resource :users do
      get :infomation, on: :collection
      patch :infomation, on: :collection
      delete :withdraw, on: :collection
    end



  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
