class User < ApplicationRecord
    has_many :shifts

    validates_presence_of :name, :user_name, :password
    validates_uniqueness_of :user_name

    # THIS METHOD IS NOT SECURE, SHOULD REFACTOR TO USE A PASSWORD_DIGEST, BCRYPT, SALT, ETC.
    def authenticate(password)
        self.password == password
    end
    
end
