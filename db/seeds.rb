# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "🌱 Seeding Keiko demo data..."

# --- Clear existing data safely ---
Shift.delete_all
User.delete_all

# --- Create Scheduler ---
scheduler = User.create!(
  name: "Demo Scheduler",
  email: "scheduler@keiko.test",
  employee_id: "S-001",
  role: :scheduler,
  password: "password",
  password_confirmation: "password",
  image_url: "https://keiko-s3.s3.us-east-2.amazonaws.com/keiko.jpg",
)

puts "Created scheduler: #{scheduler.email}"

# --- Create Employees ---
employees = [
  { name: "Alice Employee", email: "alice@keiko.test", employee_id: "E-001", image_url: "https://keiko-s3.s3.us-east-2.amazonaws.com/sally.jpg" },
  { name: "Bob Employee",   email: "bob@keiko.test",   employee_id: "E-002", image_url: "https://keiko-s3.s3.us-east-2.amazonaws.com/bert.jpg" }
].map do |attrs|
  User.create!(
    **attrs,
    role: :employee,
    password: "password",
    password_confirmation: "password"
  )
end

puts "Created #{employees.count} employees"

# --- Create Demo Shifts ---
now = Time.current.beginning_of_hour

employees.each_with_index do |employee, i|
  # Pending shift (future)
  employee.shifts.create!(
    start_time: now + (i + 1).days + 9.hours,
    end_time:   now + (i + 1).days + 17.hours,
    notes: "Regular day shift",
    acknowledged: false
  )

  # Acknowledged shift (past)
  employee.shifts.create!(
    start_time: now - (i + 1).days + 9.hours,
    end_time:   now - (i + 1).days + 17.hours,
    notes: "Completed shift",
    acknowledged: true
  )
end

puts "Created demo shifts"

puts "✅ Seeding complete!"
puts
puts "Login credentials:"
puts "Scheduler → scheduler@keiko.test / password"
puts "Employee  → alice@keiko.test / password"
