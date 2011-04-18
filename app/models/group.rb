class Group < ActiveRecord::Base
  has_many :schedules, :dependent => :destroy
  before_create :set_uuid
  accepts_nested_attributes_for :schedules

  def users_at(offset)
    schedules.map { |schedule| schedule.user_at(offset) }.compact
  end

  private

  def set_uuid
    require 'digest/md5'
    self.uuid = Digest::MD5.hexdigest(id.to_s + Time.now.to_s)
  end
end
