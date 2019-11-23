
Rails.application.routes.draw do
  root 'users#index', defaults: {format: :json}
  get '/users/:user_id/invitations', to: 'invitations#indexbyuser', defaults: {format: :json}
  get '/users/deleteall', to: 'users#destroyAll', defaults: {format: :json}    ## DELETE ALL USERS

  get '/events/:event_id/invitations', to: 'invitations#indexbyevent', defaults: {format: :json}
  resources :users, defaults: {format: :json} do
    resources :invitations, shallow:true, except: ['new', 'create','index'], defaults: {format: :json}
    resources :events, shallow:true, defaults: {format: :json} do
        resources :invitations, shallow:true, except:['index'], defaults: {format: :json}
        resources :comments, shallow:true, defaults: {format: :json}

    end
  end
  #resources :invitations
  #resources :events
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
