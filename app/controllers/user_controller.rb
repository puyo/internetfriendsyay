class UserController < ApplicationController
  def update
    session[:user] = user = User.new(params[:user])
    flash.notice = "Timezone changed to #{user.timezone.inspect}"
    return redirect_to params[:return_to] if params.has_key?(:return_to)
    return redirect_to root_url
  end
end
