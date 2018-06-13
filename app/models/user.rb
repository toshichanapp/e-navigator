class User < ApplicationRecord

  has_many :interviews

  enum gender: {male: 0, female: 1, other: 2}

  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :school_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def age
    current = Time.now.strftime('%Y%m%d').to_i
    user_birthday = birthday.strftime('%Y%m%d').to_i
    tmp_age = (current - user_birthday) / 10000
    tmp_age >= 0 ? tmp_age : 0
  end

  def approval_interview
    interviews.find_by(status: 1)
  end
end
