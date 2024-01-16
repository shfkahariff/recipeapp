class Leafe < ApplicationRecord
    after_update :deduct_leave_balance, if: :status_approved
    belongs_to :leave_balance

    mount_uploader :attachment, AttachmentUploader
    validates :name, presence: true

    private
    def status_approved
        self.status = "Approved"
    end

    def deduct_leave_balance
        leave_balance = LeaveBalance.find(self.leave_balance_id)
        leave_balance.balance = leave_balance.balance - self.duration.to_i
        leave_balance.save
    end
end
