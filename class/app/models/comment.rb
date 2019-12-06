class Comment < ApplicationRecord
  connects_to database:{
    writing: primary,
    reading: primay_replica
  }
  
  belongs_to :user
  belongs_to :event
  
  validates :body, presence: true

end
