class Group < ActiveRecord::Base
  has_many :people, :dependent => :destroy
  before_create :set_uuid
  accepts_nested_attributes_for :people

  attr_reader :person_offsets

  def user=(user)
    target = ActiveSupport::TimeZone.new(user.timezone)
    target_mon = Day.next_monday(target)
    @users_at_offset = Hash.new{|h,k| h[k] = [] }
    people.each do |person|
      source = ActiveSupport::TimeZone.new(person.timezone)
      source_mon = Day.next_monday(source)
      times = person.relative_offsets.map{|offset| source_mon + offset*60*30 }
      times.each do |time|
        offset = (time.to_i - target_mon.to_i)/(60*30) % (Day::OFFSETS_PER_WEEK)
        @users_at_offset[offset].push(person.name)
      end
    end
  end

  def users_at(offset)
    @users_at_offset[offset]
  end

  def each_time_of_day
    Day::TIME_OFFSETS.each do |offset|
      hours, mins = (offset * Day::TIME_INTERVAL).divmod(60)
      yield offset, Time.new(2000, 1, 1, hours, mins)
    end
  end

  def each_day
    Day::ALL.each do |day|
      yield day
    end
  end

  private

  def set_uuid
    require 'digest/md5'
    self.uuid = Digest::MD5.hexdigest(id.to_s + Time.now.to_s)
  end
end
