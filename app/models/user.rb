class User < ActiveRecord::Base
    has_secure_password #access through bcrypt - can use AR method 'authenticate'. Checks string entered agains bcrypt's hashing algorithm.
end