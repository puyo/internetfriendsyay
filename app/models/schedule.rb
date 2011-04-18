class Schedule < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :name
  validates_length_of :name, :minimum => 1
  validates_uniqueness_of :name, :scope => :group_id

  def user_at(offset)
    if available_at?(offset)
      name
    else
      nil
    end
  end

  private

  def available_at?(offset)
    byte, shift = offset.divmod(8)
    (data.bytes.to_a[byte].to_i & (1 << shift)) != 0
  end
end
