require "rails_helper"

RSpec.describe "Scheduler assigns shift and employee acknowledges", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:scheduler) do
    User.create!(
      name: "Scheduler",
      email: "scheduler@test.com",
      employee_id: "S1",
      role: :scheduler,
      password: "password",
      password_confirmation: "password"
    )
  end

  let!(:employee) do
    User.create!(
      name: "Employee",
      email: "employee@test.com",
      employee_id: "E1",
      role: :employee,
      password: "password",
      password_confirmation: "password"
    )
  end

  it "completes the full scheduling flow" do
    # --- Scheduler logs in ---
    visit new_user_session_path
    fill_in "Email", with: scheduler.email
    fill_in "Password", with: "password"
    click_button "Sign in"

    # --- Scheduler goes to employee shifts page ---
    visit user_shifts_path(employee)

    # --- Scheduler creates a shift ---
    fill_in "Start time", with: Time.current.strftime("%Y-%m-%d %H:%M")
    fill_in "End time",   with: 4.hours.from_now.strftime("%Y-%m-%d %H:%M")
    click_button "Save Shift"

    expect(page).to have_content("Shift created").or have_selector("tbody tr")

    # --- Employee logs in ---
    click_button "Sign out"

    visit new_user_session_path
    fill_in "Email", with: employee.email
    fill_in "Password", with: "password"
    click_button "Sign in"

    # --- Employee sees pending shift ---
    expect(page).to have_content("Pending")

    # --- Employee acknowledges shift ---
    click_link "Shift ##{Shift.last.id}"
    click_link "Acknowledge"

    # Turbo update should show acknowledged state
    expect(page).to have_content("Acknowledged")
  end
end
