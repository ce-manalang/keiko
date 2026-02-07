class Shift < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, presence: true
  validate :start_before_end
  validate :no_overlap

  private

  # Rule 1: start must be before end
  def start_before_end
    return if start_time.blank? || end_time.blank?

    if start_time >= end_time
      errors.add(:end_time, "must be after start time")
    end
  end

  # Rule 2: shifts for same user must not overlap
  def no_overlap
    return if start_time.blank? || end_time.blank? || user_id.blank?

    overlapping = Shift
      .where(user_id: user_id)
      .where.not(id: id) # ignore self when updating
      .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlapping.exists?
      errors.add(:base, "Shift overlaps with another shift")
    end
  end
end
