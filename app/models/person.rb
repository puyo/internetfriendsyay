class Person < ActiveRecord::Base
  belongs_to :group
  validates_length_of :name, :minimum => 1
  validates_uniqueness_of :name, :scope => :group_id
  validates_inclusion_of :timezone, :in => ActiveSupport::TimeZone.zones_map.keys #TZInfo::Timezone.all.map(&:name)

  def user_at(offset)
    if available_at?(offset)
      name
    else
      nil
    end
  end

  def available_at=(value)
    result = [0]*Day::OFFSETS_PER_WEEK
    value.keys.each do |offset|
      byte, shift = offset.to_i.divmod(8)
      result[byte] |= (1 << shift)
    end
    self.data = result.pack("c#{result.size}")
  end

  def available_at
    result = {}
    (0..Day::OFFSETS_PER_WEEK).each do |offset|
      result[offset] = true if available_at?(offset)
    end
    result
  end

  def minute_offsets(target_timezone)
    if target_timezone.is_a?(String)
      target_timezone = TZInfo::Timezone.get(target_timezone)
    end
    target_mon = Day.next_monday(target_timezone)
    source_tz = TZInfo::Timezone.get(timezone)
    source_mon = Day.next_monday(source_tz)
    times = relative_offsets.map{|offset| source_mon + offset*60*Day::TIME_INTERVAL }
    times.map{|time| (time.to_i - target_mon.to_i)/60 % (Day::OFFSETS_PER_WEEK*Day::TIME_INTERVAL) }
  end

  def available_at?(offset)
    byte, shift = offset.to_i.divmod(8)
    (data.to_s.bytes.to_a[byte].to_i & (1 << shift)) != 0
  end

  def relative_offsets
    available_at.keys
  end
end
