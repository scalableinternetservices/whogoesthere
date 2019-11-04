class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  
  enum response: [:no_response, :yes, :no, :maybe]
end
