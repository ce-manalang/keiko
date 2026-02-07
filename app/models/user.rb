class User < ApplicationRecord
  enum role: { employee: 0, scheduler: 1 }

  validates :name, :email, :employee_id, :role, presence: true
  validates :email, :employee_id, uniqueness: true
end
