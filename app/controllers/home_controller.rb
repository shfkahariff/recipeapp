class HomeController < ApplicationController
  def index
  end

  def profile
  end

  #admin dashboard
  def admin_dashboard
    @users = User.all
    @leaves = Leafe.all
    @leave_balances = LeaveBalance.all
  end
  #sidekiq: bundle exec sidekiq -C config/sidekiq.yml
end
