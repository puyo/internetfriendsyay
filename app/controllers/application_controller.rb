class ApplicationController < ActionController::Base
  before_action :load_user

  attr_reader :user

  def load_user
    tz = session.fetch(:user, {}).fetch('timezone', 'Sydney')
    @user = User.new(timezone: tz)
  end
end
