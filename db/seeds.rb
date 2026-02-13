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
  image_url: "https://github-production-user-asset-6210df.s3.amazonaws.com/353784/549137511-8bb5a193-88b2-4044-89a9-f817ded9c2ad.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20260213%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260213T021329Z&X-Amz-Expires=300&X-Amz-Signature=f919ca0f2eab3d9dcdaa64a1bf3804c5d78077d1cbcdb32064f0a705a7088d5f&X-Amz-SignedHeaders=host",
)

puts "Created scheduler: #{scheduler.email}"

# --- Create Employees ---
employees = [
  { name: "Alice Employee", email: "alice@keiko.test", employee_id: "E-001", image_url: "https://github-production-user-asset-6210df.s3.amazonaws.com/353784/549135931-f1167c59-e19e-4d78-b6d9-a3c31ef4685d.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20260213%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260213T021356Z&X-Amz-Expires=300&X-Amz-Signature=5c604f9aa3bb7bdeb459a6dc1276d0c175467dc9199c3f7d873a3ae1d51fae8d&X-Amz-SignedHeaders=host" },
  { name: "Bob Employee",   email: "bob@keiko.test",   employee_id: "E-002", image_url: "https://github-production-user-asset-6210df.s3.amazonaws.com/353784/549137983-e7fbca58-900a-4e4e-9140-d81df25d5f87.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20260213%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260213T021427Z&X-Amz-Expires=300&X-Amz-Signature=d5c0b5806f383bc3c49a352358e0cd50fbe5554afc8d61c0bb23a5a7f1eeeaa6&X-Amz-SignedHeaders=host" }
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
