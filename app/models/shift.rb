class Shift < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, presence: true
  validate :start_before_end

  private

  def start_before_end
    return if start_time.blank? || end_time.blank?

    if start_time >= end_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
