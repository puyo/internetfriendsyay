# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# A group schedule, representing the combined schedule of multiple people.
class Schedule < ApplicationRecord
  has_many :people, dependent: :destroy
  before_create :set_uuid
  accepts_nested_attributes_for :people

  HOURS_PER_DAY = 24
  INDEXES_PER_HOUR = 2
  INDEXES_PER_DAY = HOURS_PER_DAY * INDEXES_PER_HOUR
  INDEXES_PER_WEEK = 7 * INDEXES_PER_DAY
  MINUTES_PER_INDEX = 60 / INDEXES_PER_HOUR

  TIMES_OF_DAY = (0...INDEXES_PER_DAY).map do |time_of_day_index|
    hours, mins = (time_of_day_index * MINUTES_PER_INDEX).divmod(60)
    Time.utc(2000, 1, 1, hours, mins)
  end

  DAY_NAMES = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  def people_at_indexes(timezone)
    result = Hash.new { |h, k| h[k] = [] }
    monday = next_monday(timezone)
    people.each do |person|
      person_mon = next_monday(person.timezone)
      index_offset = (person_mon.to_i - monday.to_i) / (60 * MINUTES_PER_INDEX)
      add_person_to_schedule(person, index_offset, result)
    end
    result
  end

  def utc_index(index, timezone)
    user_monday = next_monday(timezone) + (index * (60 * MINUTES_PER_INDEX))
    utc_monday = next_monday('UTC')
    index_offset = (user_monday.to_i - utc_monday.to_i) / (60 * MINUTES_PER_INDEX)
    index_offset % INDEXES_PER_WEEK
  end

  def day_indexes(time_of_day_index)
    (time_of_day_index...(time_of_day_index + INDEXES_PER_WEEK)).step(INDEXES_PER_DAY).to_a
  end

  def to_param
    uuid
  end

  private

  def add_person_to_schedule(person, index_offset, schedule_hash)
    person.available_indexes.each do |person_index|
      index = (person_index + index_offset) % INDEXES_PER_WEEK
      schedule_hash[index].push(person)
    end
  end

  def set_uuid
    require 'digest/md5'
    self.uuid = Digest::MD5.hexdigest(id.to_s + Time.current.to_s)
  end

  def next_monday(tz_name)
    tz = ActiveSupport::TimeZone.new(tz_name)
    result = tz.now
    until result.monday?
      result += 60 * 60 * 24 # one day
    end
    result = Time.utc(result.year, result.month, result.day) # round off minutes and seconds
    tz.tzinfo.local_to_utc(result)
  end
end
