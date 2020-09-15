class User < ApplicationRecord
    validates :username, :email, presence: true
    validates :email, uniqueness: true
    validates :username, uniqueness: true
end

