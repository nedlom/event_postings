class User < ActiveRecord::Base
    has_secure_password #access through bcrypt - can use AR method 'authenticate'. Checks string entered agains bcrypt's hashing algorithm.
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    
    has_many :events
end