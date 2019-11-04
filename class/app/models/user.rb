class User < ApplicationRecord
  has_many :events
  has_many :invitations
  has_many :comments
  
  validates :name, :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, uniqueness: true
  
end
