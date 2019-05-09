class SessionsController < ApplicationController
   def create
      @user = User.find_or_create_by(uid: auth[:uid]) do |user|
         user.name = auth['info']['name']
         user.email = auth['info']['email']
         user.image = auth['info']['image']
      end
      session[:user_id] = @user.id
      @user
      redirect_to 'welcome/home'
   end

   def destroy
      session.clear
      redirect_to root_path, alert: "Logged out"
   end

   private
      def auth
         request.env['omniauth.auth']
      end
end