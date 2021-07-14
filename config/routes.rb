Rails.application.routes.draw do

  resources :cruises do
      member do
        get :aspect, to: 'observations#aspect'
      end
    #~ member do
      #~ get :aspect, to: 'observations#aspect'
    #~ end
  #~ get "aspect(.:format)", to: 'observations#aspect', as: 'aspect'
    resources :observations, except: [:new], shallow: true do
      collection do
        
        post :import
        post :import_follow_up
	post :upload
        delete :all
        delete :unapproved
        delete :invalid
      end
      member do
        patch :approve
      end
      
      resources :photos, shallow: false
      resources :comments, except: [:index, :show], shallow: false
    end
    resources :charts, only: [:index] do
      get :total_concentration, on: :collection
      get :ice_type, on: :collection
    end
    post :approve, on: :member
    post :approve_observations, on: :member
    resources :uploaded_files, only: [:create, :new]
    resources :photos, only: [:index] do
      get :download
    end
  end
  resources :lookups, only: [:index, :show]

  #~ get '/cruises/:cruise_id/aspcet(.:format)', to: 'observations#aspcet', as: 'cruise_aspect'
  #~ get "/cruises/:cruise_id/aspect(.:format)", to: 'observations#aspect', as: 'aspect'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  get '/auth/:provider/disable', to: 'users#disable_provider'
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  resources :sessions
  resources :memberships

  get '/about', to: 'pages#about'
  get '/data_guide', to: 'pages#data_guide'
  get '/assist', to: 'pages#assist'

  resources :users

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'cruises#index'

end
