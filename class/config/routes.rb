
Rails.application.routes.draw do
  root 'users#index'
  get '/users/:user_id/invitations', to: 'invitations#indexbyuser', defaults: {format: :json}
  get '/events/:event_id/invitations', to: 'invitations#indexbyevent', defaults: {format: :json}
  resources :users, defaults: {format: :json} do
    resources :invitations, shallow:true, except: ['new', 'create','index']
    resources :events, shallow:true do
        resources :invitations, shallow:true, except:['index']
        resources :comments, shallow:true

    end
  end
  #resources :invitations
  #resources :events
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
