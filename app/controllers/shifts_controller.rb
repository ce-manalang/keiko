class ShiftsController < ApplicationController
  before_action :require_scheduler!, except: [ :acknowledge, :mine, :show, :add_employee_note ]
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
        format.turbo_stream { redirect_to user_shifts_path(@user), status: :see_other, notice: "Shift created." }
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
        format.turbo_stream { redirect_to user_shifts_path(@user), status: :see_other, notice: "Shift updated." }
        format.html { redirect_to user_shifts_path(@user), notice: "Shift updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shift.destroy

    respond_to do |format|
      format.turbo_stream { redirect_to user_shifts_path(@user), status: :see_other, notice: "Shift deleted." }
      format.html { redirect_to user_shifts_path(@user), notice: "Shift deleted." }
    end
  end

  def acknowledge
    @shift = current_user.shifts.find(params[:id])
    @shift.update!(acknowledged: true)

    respond_to do |format|
      format.turbo_stream { redirect_to my_shifts_path, status: :see_other }
      format.html { redirect_to my_shifts_path }
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

  def add_employee_note
    @shift = current_user.shifts.find(params[:id])
    if @shift.update(employee_note_params)
      respond_to do |format|
        format.turbo_stream { redirect_to user_shift_path(@user, @shift), status: :see_other, notice: "Note added." }
        format.html { redirect_to user_shift_path(@user, @shift), notice: "Note added." }
      end
    else
      render :show, status: :unprocessable_entity
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
    params.require(:shift).permit(:start_time, :end_time, :notes, :employee_notes)
  end

  def employee_note_params
    params.require(:shift).permit(:employee_notes)
  end
end
