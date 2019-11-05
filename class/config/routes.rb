Rails.application.routes.draw do
  root 'users#index'
  resources :users do
    resources :events do
        resources :invitations, shallow:true
    end
  end
  resources :comments
  #resources :invitations
  #resources :events
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
