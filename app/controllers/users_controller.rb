# Manage user resources.
class UsersController < ApplicationController
  def update
    session[:user] = user = User.new(user_params)
    flash.notice = "Timezone changed to #{user.timezone.inspect}"
    if params.key?(:schedule_uuid)
      redirect_to schedule_path(schedule_uuid)
      return
    end
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:timezone)
  end

  def schedule_uuid
    params.permit(:schedule_uuid)[:schedule_uuid]
  end
end
