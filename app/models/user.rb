class User
  include ActiveModel::Model

  attr_accessor :timezone

  def initialize(attributes={})
    super
    self.timezone ||= 'Sydney'
  end

  def persisted?
    false
  end
end
