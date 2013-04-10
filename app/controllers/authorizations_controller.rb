class AuthorizationsController < ApplicationController
skip_authorization_check
  def create
    @current_user = User.find_or_create_from_oauth(request.env['omniauth.auth'])
    if @current_user
      UserSession.create(current_user,true)
      redirect_to root_url, :notice => "Logged In"
    else
      redirect_to root_url, :flash => {:error => "Not Authorized"}
    end
  end

end
