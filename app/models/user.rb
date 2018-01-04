class User < ApplicationRecord
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :rememberable, :recoverable, :trackable
  devise :database_authenticatable, :registerable, :validatable
end
