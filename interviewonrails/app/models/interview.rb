class Interview < ApplicationRecord
    has_many :users, as: :participant1
    has_many :users, as: :participant2
end
