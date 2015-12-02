# == Schema Information
#
# Table name: people
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  name        :string           not null
#  timezone    :string           not null
#  data        :binary
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# An individual person's information within a group's schedule.
class Person < ActiveRecord::Base
  belongs_to :schedule

  validates :name,
            length: { minimum: 1, maximum: 20 },
            uniqueness: { scope: :schedule_id }
  validates :timezone,
            inclusion: { in: ActiveSupport::TimeZone.zones_map.keys }

  def available_at=(value)
    result = [0] * Schedule::INDEXES_PER_WEEK
    value.each do |index|
      byte, shift = byte_shift(index)
      result[byte] |= (1 << shift)
    end
    self.data = result.pack("c#{result.size}")
  end

  def available_at
    result = {}
    (0...Schedule::INDEXES_PER_WEEK).each do |index|
      result[index] = true if available_at?(index)
    end
    result
  end

  def available_at?(index)
    byte, shift = byte_shift(index)
    (data.to_s.bytes.to_a[byte].to_i & (1 << shift)) != 0
  end

  def available_indexes
    available_at.keys
  end

  private

  def byte_shift(index)
    index.to_i.divmod(8)
  end
end
