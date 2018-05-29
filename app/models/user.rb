class User < ApplicationRecord

  enum gender: {male: 0, female: 1, other: 2}

  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :school_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
