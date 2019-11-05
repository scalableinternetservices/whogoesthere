class Event < ApplicationRecord
  belongs_to :user
  has_many :invitations
  has_many :comments
  
  validates :name, :location, :start_time, :end_time, presence: true
  
end
