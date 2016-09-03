Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'

  get 'articles/index', as: 'articles'
  get 'about/show', as: 'about'

  namespace :admin do
    get 'dashboard/index', as: 'dashboard'
    get 'articles/index', as: 'articles'
    get 'social/index', as: 'social'
  end
end
