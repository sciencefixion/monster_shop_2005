class User < ApplicationRecord
    validates_presence_of :name, :address, :city, :state, :zip, :email, :password

    has_secure_password
end