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
      "https://keiko-s3.s3.us-east-2.amazonaws.com/ate+gili.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/lolo.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/chesca.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/mikki.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/kuya+thonns.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/kai.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/jahz.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/ate+azul.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/nanay.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/tatay.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/kuya+aris.jpg",
      "https://keiko-s3.s3.us-east-2.amazonaws.com/ce.jpg"
    ].sample
  end
end
