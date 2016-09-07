Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'

  get 'articles/index', as: 'articles'
  get 'articles/show', as: 'article'
  get 'about/show', as: 'about'


  namespace :admin do
    get 'dashboard/index', as: 'dashboard'
    resources :articles
    resources :socials
    resources :categories
  end
end
