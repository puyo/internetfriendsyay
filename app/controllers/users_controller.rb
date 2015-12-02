# Manage user resources.
class UsersController < ApplicationController
  def update
    session[:user] = user = User.new(params[:user])
    flash.notice = "Timezone changed to #{user.timezone.inspect}"
    if params.key?(:schedule_uuid)
      redirect_to schedule_path(params[:schedule_uuid])
      return
    end
    redirect_to root_url
  end
end
