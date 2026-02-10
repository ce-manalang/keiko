class DashboardController < ApplicationController
  before_action :require_employee!

  def show
    @shifts = current_user.shifts.order(:start_time)
  end
end
