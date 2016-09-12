Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home_page#show'

  get 'articles/index', as: 'articles'
  get 'articles/show', as: 'article'
  get 'categories/show', as: 'category'
  get 'about_page/show', as: 'about_page'


  namespace :admin do
    get 'dashboard/index', as: 'dashboard'
    resources :articles
    resources :socials
    resources :categories
    resources :tags
    resource :about_page, except: [:index, :destroy]
    resources :home_pages, except: [:index, :destroy]
    resources :projects
    get '/add_service' => 'home_pages#add_service', as: 'add_service'
  end
end
