class Group < ActiveRecord::Base
  has_many :schedules

  before_create :set_uuid

  accepts_nested_attributes_for :schedules

  attr_reader :users_at_offsets

#  def to_param
#    {:uuid => uuid}
#  end

  def users_at(offset)
    schedules.map { |schedule| schedule.user_at(offset) }.compact
  end

  private

  def set_uuid
    require 'digest/md5'
    self.uuid = Digest::MD5.digest(id.to_s + Time.now.to_s)
  end

  # [[<User 1>, <User 2>], [<User 1>]]
  #def users_at_offset(offset)
    #offsets.map { |offset| users_at(offset) }
  #end

  def offsets
    Day::ALL.map(&:offsets).flatten
  end
end

class Day
  HOURS_PER_DAY = 24
  OFFSETS_PER_HOUR = 2
  OFFSETS_PER_DAY = HOURS_PER_DAY * OFFSETS_PER_HOUR
  TIME_INTERVAL = 60 / OFFSETS_PER_HOUR
  TIME_OFFSETS = 0...OFFSETS_PER_DAY

  def initialize(opts = nil)
    @opts = opts || {}
  end

  def name
    @opts[:name]
  end

  def offsets
    TIME_OFFSETS.map{|time_offset| @opts[:day_offset]*OFFSETS_PER_DAY  + time_offset }
  end

  ALL = [
    Day.new(:name => 'Monday', :day_offset => 0),
    Day.new(:name => 'Tuesday', :day_offset => 1),
    Day.new(:name => 'Wednesday', :day_offset => 2),
    Day.new(:name => 'Thursday', :day_offset => 3),
    Day.new(:name => 'Friday', :day_offset => 4),
    Day.new(:name => 'Saturday', :day_offset => 5),
    Day.new(:name => 'Sunday', :day_offset => 6),
  ]
end
