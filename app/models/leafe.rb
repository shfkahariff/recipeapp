class Leafe < ApplicationRecord
    after_update :deduct_leave_balance, if: :status_approved
    belongs_to :leave_balance

    mount_uploader :attachment, AttachmentUploader
    validates :name, presence: true

    def start_time
        self.startDate ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

    def end_time
        self.endDate ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

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
