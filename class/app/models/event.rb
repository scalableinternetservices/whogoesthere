class Event < ApplicationRecord
  belongs_to :user
  has_many :invitations
  has_many :comments

end
