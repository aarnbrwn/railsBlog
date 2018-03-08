class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
		@user = User.find_by_username(params[:username])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			flash[:message] = "Login successful"
			redirect_to "/users/#{@user.id}"
		else
			flash[:message] = "Login failed"
			redirect_to "/login"
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:message] = "Logout successful"
		redirect_to '/'
	end
end
