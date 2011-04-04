class Schedule < ActiveRecord::Base
  belongs_to :user

  def user_at(offset)
    user if available_at?(offset)
  end

  private

  def available_at?(offset)
    byte, shift = offset.divmod(8)
    (data.bytes.to_a[byte] & (1 << shift)) != 0
  end
end
