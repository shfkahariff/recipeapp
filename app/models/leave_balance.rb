class LeaveBalance < ApplicationRecord
    belongs_to :user
    has_many :leaves, dependent: :destroy
end
