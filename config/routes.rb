Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home_page#show'

  get 'about' => 'about_page#show',  as: 'about_page'

  get '/robots.:format' => 'static_pages#robots'

  get "sitemap.xml" => "static_pages#sitemap", :format => "xml", :as => :sitemap  
  

  scope module: 'blog' do
    #get 'categories/show',  as: 'category'
    get    'categories/:id' => 'categories#show', :as => 'category'
    get    'tags/:id' => 'tags#show', :as => 'tag'
    get '/search' => 'search#index', as: 'search'
    resources :articles, only: [:index, :show] do
      resources :comments, only: [:create]
    end
  end

  namespace :admin do
    get 'dashboard/index', as: 'dashboard'
    resources :articles do
      resources :images
      get '/add_image' => 'articles#add_image', as: 'add_image'
      get '/add_tag'   => 'articles#add_tag',   as: 'add_tag'
    end
    resources :images, only: [:index]
    resources :comments, only: [:index, :destroy]
    resources :socials
    resources :categories
    resources :tags
    resource :about_page, except: [:index, :destroy]
    resource :home_page, except: [:index, :destroy]
    get '/add_service' => 'home_pages#add_service', as: 'add_service'
    resources :projects
    resource :setting, except: [:index, :destroy]
    namespace :settings do
      patch 'password/update', as: 'update_password'
      patch 'email/update', as: 'update_email'
    end
  end

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  get '*url' => 'errors#not_found'
end
