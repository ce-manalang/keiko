require "rails_helper"

RSpec.describe Shift, type: :model do
  let(:user) do
    User.create!(
      name: "Test",
      email: "test@example.com",
      employee_id: "E1",
      role: :employee,
      password: "password",
      password_confirmation: "password"
    )
  end

  let(:start_time) { Time.current }
  let(:end_time)   { 4.hours.from_now }

  subject do
    described_class.new(
      user: user,
      start_time: start_time,
      end_time: end_time,
      acknowledged: false
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "requires start_time" do
    subject.start_time = nil
    expect(subject).not_to be_valid
  end

  it "requires end_time" do
    subject.end_time = nil
    expect(subject).not_to be_valid
  end

  it "requires start_time before end_time" do
    subject.start_time = end_time
    subject.end_time = start_time
    expect(subject).not_to be_valid
  end

  describe "overlap validation" do
    before do
      Shift.create!(
        user: user,
        start_time: start_time,
        end_time: end_time
      )
    end

    it "does not allow overlapping shifts" do
      overlapping = Shift.new(
        user: user,
        start_time: 2.hours.from_now,
        end_time: 6.hours.from_now
      )

      expect(overlapping).not_to be_valid
      expect(overlapping.errors.full_messages)
        .to include("Shift overlaps with another shift")
    end

    it "allows non-overlapping shifts that touch edges" do
      touching = Shift.new(
        user: user,
        start_time: end_time,
        end_time: 8.hours.from_now
      )

      expect(touching).to be_valid
    end
  end
end
