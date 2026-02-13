class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  enum :role, { employee: 0, scheduler: 1 }

  has_many :shifts, dependent: :destroy

  validates :name, :email, :employee_id, :role, presence: true
  validates :email, :employee_id, uniqueness: true

  before_validation :assign_random_image_url, on: :create

  private

  def assign_random_image_url
    return if image_url.present?

    self.image_url = [
      "https://github.com/user-attachments/assets/e7fbca58-900a-4e4e-9140-d81df25d5f87",
      "https://github.com/user-attachments/assets/f2fcfa91-d92e-474c-8083-677079630bb7",
      "https://github.com/user-attachments/assets/2eb9ccd7-8b89-4545-bb52-84c334b4dbe3",
      "https://github.com/user-attachments/assets/a3b6093d-9571-45fd-8a95-06009a77e58c",
      "https://github.com/user-attachments/assets/85adac02-be7b-4905-b8ec-39fd0d8b9ca9",
      "https://github.com/user-attachments/assets/ea68afbd-f1e7-4f14-8fd4-5f7e80d43a9f",
      "https://github.com/user-attachments/assets/de6f33e3-8d9e-4c26-8023-af15a54c79ad",
      "https://github.com/user-attachments/assets/cf90dcfb-6a1c-4c20-9488-7efda0e9655c",
      "https://github.com/user-attachments/assets/c4a40e33-49e7-4ba8-8a4f-e97f7e7d822d",
      "https://github.com/user-attachments/assets/508a4eec-1f0f-4558-afb1-ba0059e2fb45",
      "https://github.com/user-attachments/assets/722c63d6-67ed-4c25-ab91-8afe813cae76",
      "https://github.com/user-attachments/assets/0da61d19-b350-43b0-a149-4ec0e80075cd"
    ].sample
  end
end
