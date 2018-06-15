class Interview < ApplicationRecord
  belongs_to :user

  enum status: {dissmissed: 0, approval: 1, pending: 2}

  validates :date, presence: true, is_later_now: true
end
