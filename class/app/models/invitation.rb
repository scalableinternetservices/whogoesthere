class Invitation < ApplicationRecord
  connects_to database:{
    writing: primary,
    reading: primay_replica
  }
  
  belongs_to :user
  belongs_to :event
  
  enum response: [:no_response, :yes, :no, :maybe]
end
