class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_user
  
  private

  def load_user
    @user = session[:user]
  end
end
