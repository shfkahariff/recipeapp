class Leafe < ApplicationRecord
    after_update :deduct_leave_balance, if: :status_approved
    after_create_commit :notify_recipient
    after_update :notify_recipient, if: :saved_change_to_status?
    before_destroy :cleanup_notifications

    belongs_to :leave_balance

    mount_uploader :attachment, AttachmentUploader
    validates :name, presence: true

    has_noticed_notifications model_name: 'Notification'
    has_many :notifications, through: :leave_balance, dependent: :destroy


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

    def notify_recipient
        if self.status == "Pending"
          # Notify all admin users when a leave is applied
          User.admin.each do |admin|
            LeaveRequest.with(leafe: self, recipient: admin).deliver_later(admin)
          end
        end
        if ["Approved", "Declined"].include?(self.status)
          # Notify the employee when a leave is approved or declined
          LeaveRequest.with(leafe: self, recipient: self.leave_balance.user).deliver_later(self.leave_balance.user)
        end
    end

    def cleanup_notifications
        notifications_as_leafe.destroy_all
    end
end
