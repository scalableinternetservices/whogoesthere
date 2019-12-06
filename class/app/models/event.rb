class Event < ApplicationRecord
  connects_to database:{
    writing: primary,
    reading: primay_replica
  }
  
  belongs_to :user
  has_many :invitations, dependent: :destroy
  has_many :comments
  
  validates :name, :location, :start_time, :end_time, presence: true
  
end
