class DashboardController < ApplicationController
  def show
    @shifts = current_user.scheduler? ? Shift.includes(:user).all.order(:start_time) : current_user.shifts.includes(:user).order(:start_time)
  end
end
