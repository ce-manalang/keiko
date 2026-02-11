class ShiftsController < ApplicationController
  before_action :require_scheduler!, except: [ :acknowledge, :mine, :show ]
  before_action :require_employee!, only: :mine
  before_action :set_user, except: :mine
  before_action :set_shift, only: %i[edit update destroy]

  def mine
    @shifts = current_user.shifts.order(:start_time)
  end

  def index
    @shifts = @user.shifts.order(:start_time)
    @shift  = @user.shifts.new
  end

  def create
    @shift = @user.shifts.new(shift_params)

    if @shift.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_shifts_path(@user), notice: "Shift created." }
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @shift.update(shift_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_shifts_path(@user), notice: "Shift updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shift.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to user_shifts_path(@user), notice: "Shift deleted." }
    end
  end

  def acknowledge
    @shift = current_user.shifts.find(params[:id])
    @shift.update!(acknowledged: true)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to mine_shifts_path }
    end
  end

  def show
    @shift =
      if current_user.scheduler?
        Shift.find(params[:id])
      else
        current_user.shifts.find(params[:id])
      end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shift
    @shift = @user.shifts.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :notes)
  end
end
