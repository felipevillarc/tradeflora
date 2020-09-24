class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :areas 
  has_many :proposals, through: :areas, source: :trade
  has_many :trades
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
