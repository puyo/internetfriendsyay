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

  def available_at?(offset)
    byte, shift = offset.to_i.divmod(8)
    (data.to_s.bytes.to_a[byte].to_i & (1 << shift)) != 0
  end

  def relative_offsets
    available_at.keys
  end
end
