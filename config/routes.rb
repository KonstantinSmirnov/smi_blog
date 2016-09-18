Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home_page#show'

  get 'categories/show',  as: 'category'
  get 'about_page/show',  as: 'about_page'

  get 'search/index',     as: 'search'

  resources :articles, only: [:index, :show] do
    resources :comments, only: [:create]
  end

  namespace :admin do
    get 'dashboard/index', as: 'dashboard'
    resources :articles do
      resources :images
      get '/add_image' => 'articles#add_image', as: 'add_image'
    end
    resources :images, only: [:index]
    resources :comments, only: [:index]
    resources :socials
    resources :categories
    resources :tags
    resource :about_page, except: [:index, :destroy]
    resource :home_page, except: [:index, :destroy]
    get '/add_service' => 'home_pages#add_service', as: 'add_service'
    resources :projects
    get 'settings/index', as: 'settings'
    namespace :settings do
      patch 'password/update', as: 'update_password'
      patch 'email/update', as: 'update_email'
    end

  end

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  get '*url' => 'errors#not_found'
end
