class Day
  HOURS_PER_DAY = 24
  OFFSETS_PER_HOUR = 2
  OFFSETS_PER_DAY = HOURS_PER_DAY * OFFSETS_PER_HOUR
  OFFSETS_PER_WEEK = 7 * OFFSETS_PER_DAY
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
