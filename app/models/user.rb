# The person currently using the service. Tracks their timezone setting.
class User
  include ActiveModel::Model

  attr_accessor :timezone

  def initialize(timezone:)
    super
    self.timezone = timezone
  end

  def persisted?
    false
  end
end
