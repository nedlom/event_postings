class User < ActiveRecord::Base
  has_many :events
  has_secure_password 
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
end