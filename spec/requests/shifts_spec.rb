require 'rails_helper'

RSpec.describe "Shifts", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) {
    User.create!(
      name: "Test Employee",
      email: "employee@example.com",
      password: "password",
      employee_id: "E999",
      role: :employee
    )
  }
  let(:shift) {
    user.shifts.create!(
      start_time: Time.zone.now + 1.day,
      end_time: Time.zone.now + 1.day + 8.hours
    )
  }

  describe "PATCH /acknowledge" do
    before do
      sign_in user
    end

    it "allows employee to acknowledge their own shift" do
      patch acknowledge_user_shift_path(user, shift)
      expect(response).to redirect_to(my_shifts_path)
      expect(shift.reload.acknowledged).to be true
    end
  end
end
