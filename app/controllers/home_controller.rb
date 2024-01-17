class HomeController < ApplicationController
  def index
    end_date  = Time.now.beginning_of_year + 5.years
        @leaves = Leafe.where(
            startDate: Time.now.beginning_of_year..end_date
        )
        #add public_holiday
        @holidays = Holiday.where(
            startholiday: Time.now.beginning_of_year..end_date
        )
  end

  def profile
  end

  #admin dashboard
  def admin_dashboard
    @users = User.all
    @leaves = Leafe.all
    @leave_balances = LeaveBalance.all
  end
end
