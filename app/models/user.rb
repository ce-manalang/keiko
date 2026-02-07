class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :role, { employee: 0, scheduler: 1 }

  has_many :shifts, dependent: :destroy

  validates :name, :email, :employee_id, :role, presence: true
  validates :email, :employee_id, uniqueness: true
end
