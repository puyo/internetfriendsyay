# Manage user resources.
class UsersController < ApplicationController
  def update
    user = User.new(timezone: user_params[:timezone])
    session[:user] = user_params
    flash.notice = "Timezone changed to #{user.timezone.inspect}"
    if params.key?(:schedule_uuid)
      redirect_to schedule_path(schedule_uuid)
      return
    end
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:timezone)
  end

  def schedule_uuid
    params.require(:schedule_uuid)
  end
end
