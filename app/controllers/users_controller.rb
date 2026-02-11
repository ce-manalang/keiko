class UsersController < ApplicationController
  before_action :require_scheduler!
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.order(:name)
  end

  def show
    @recent_shifts = @user.shifts.order(start_time: :desc).limit(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    permitted_params = %i[name email employee_id password password_confirmation]
    permitted_params << :role if current_user&.scheduler?
    p = params.require(:user).permit(permitted_params)
    p.delete(:password) if p[:password].blank?
    p.delete(:password_confirmation) if p[:password_confirmation].blank?
    p
  end
end
