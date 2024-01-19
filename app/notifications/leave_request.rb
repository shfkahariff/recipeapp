  # To deliver this notification:
#
# LeaveRequest.with(post: @post).deliver_later(current_user)
# LeaveRequest.with(post: @post).deliver(current_user)

class LeaveRequest < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @leave = params[:leafe]
    @recipient = params[:recipient]
  
    return "User not found" unless @recipient
  
    if @recipient.admin?
      return "#{@leave.name} has applied for #{@leave.leave_balance.leavetype}"
    elsif @recipient.employee?
      return "Your #{@leave.leave_balance.leavetype} has been approved by admin" if @leave.status == "Approved"
      return "Your #{@leave.leave_balance.leavetype} has been declined by admin" if @leave.status == "Declined"
    end
  
    "Unknown Role"
  end
  
  def url
    @recipient = params[:recipient]

    return "User not found" unless @recipient

    if @recipient.admin?
      return admin_dashboard_path
    elsif @recipient.employee?
      return leafe_path(params[:leafe])
    end

    "Unknown Role"
  end
end
