class Leafe < ApplicationRecord
    after_update :deduct_leave_balance, if: :status_approved
    after_create_commit :notify_recipient
    after_update :notify_recipient, if: :saved_change_to_status?
    before_destroy :cleanup_notifications

    belongs_to :leave_balance

    mount_uploader :attachment, AttachmentUploader
    validates :name, presence: true
    validates :startDate, presence: true
    validates :endDate, presence: true
    validates :duration, presence: true
    validates :reason, presence: true
    validates :status, presence: true
    validates :attachment, presence: true, if: :sick_leave?


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
        if leave_balance.leavetype == "Unpaid Leave"
            leave_balance.balance = leave_balance.balance + self.duration.to_i
        else
            leave_balance.balance = leave_balance.balance - self.duration.to_i
        end
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

    def sick_leave?
        self.leave_balance.leavetype == "Sick Leave"
    end
end
