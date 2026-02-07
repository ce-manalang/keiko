require "rails_helper"

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      name: "Test User",
      email: "test@example.com",
      employee_id: "E001",
      role: :employee
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without an email" do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without an employee_id" do
    subject.employee_id = nil
    expect(subject).not_to be_valid
  end

  it "enforces unique email" do
    subject.save!
    duplicate = subject.dup
    expect(duplicate).not_to be_valid
  end

  it "enforces unique employee_id" do
    subject.save!
    duplicate = subject.dup
    duplicate.email = "other@example.com"
    expect(duplicate).not_to be_valid
  end

  it "defines roles enum" do
    expect(User.roles.keys).to contain_exactly("employee", "scheduler")
  end
end
