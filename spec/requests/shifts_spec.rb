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
  let(:scheduler) {
    User.create!(
      name: "Test Scheduler",
      email: "scheduler@example.com",
      password: "password",
      employee_id: "S001",
      role: :scheduler
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

  describe "Scheduler actions" do
    before do
      sign_in scheduler
    end

    it "allows scheduler to see the edit shift page" do
      get edit_user_shift_path(user, shift)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Edit Shift")
    end

    it "allows scheduler to update a shift" do
      patch user_shift_path(user, shift), params: { shift: { notes: "Updated notes" } }
      expect(response).to redirect_to(user_shifts_path(user))
      expect(shift.reload.notes).to eq("Updated notes")
    end
  end
end
