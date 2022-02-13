class User < ApplicationRecord
    validates :uid, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    has_many :articles
end
