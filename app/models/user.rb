class User
  def initialize(opts = nil)
    @opts = opts
  end

  def timezone
    opts[:timezone] || ''
  end

  def persisted?
    false
  end

  private

  def opts
    @opts || {}
  end
end
