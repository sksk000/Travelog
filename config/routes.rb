Rails.application.routes.draw do
  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
    get 'homes/about' => 'homes#about'
    get 'users/mypage' => 'users#mypage', as: :mypage
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
