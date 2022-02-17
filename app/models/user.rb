class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable, :omniauthable
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_many :articles
end
