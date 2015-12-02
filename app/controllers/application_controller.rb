# Functionality inherited by all controllers in this project.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_user

  protected

  attr_reader :user

  private

  def load_user
    @user = session[:user] || User.new
  end

end
