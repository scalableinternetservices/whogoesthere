class User < ApplicationRecord
  connects_to database:{
    writing: primary,
    reading: primay_replica
  }
  
  has_many :events, dependent: :destroy
  has_many :invitations
  has_many :comments
  
  validates :name, :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, uniqueness: true
  
end
