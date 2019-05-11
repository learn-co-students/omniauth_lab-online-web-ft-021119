class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end

    session[:user_id] = @user.id

    render 'welcome/home'
  end

  #from video
  # oauth_email = request.env["omniauth.email"]["email"]
  # if @user = User.find_by(email: oauth_email)
  #   #existing user
  #   session[:user_id] = @user.id
  #   redirect_to root_path
  # else
  #   @user = User.new(email: oauth_email)
  #   if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to root_path
  #   else
  #     @users.error.full_messages
  #   end
  # end
  
  private

  def auth
    request.env['omniauth.auth']
  end
end
