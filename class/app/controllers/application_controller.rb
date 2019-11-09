class ApplicationController < ActionController::Base  
    protect_from_forgery with: :null_session  ## For development purpose, remove later.
end
