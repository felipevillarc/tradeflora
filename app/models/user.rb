class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :areas, dependent: :destroy
  has_many :proposals, through: :areas, source: :trade, dependent: :destroy
  has_many :trades, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
