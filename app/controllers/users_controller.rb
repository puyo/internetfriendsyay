# Manage user resources.
class UsersController < ApplicationController
  def update
    session[:user] = user = User.new(params[:user])
    flash.notice = "Timezone changed to #{user.timezone.inspect}"
    return redirect_to params[:return_to] if params.key?(:return_to)
    redirect_to root_url
  end
end
