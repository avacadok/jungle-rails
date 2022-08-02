class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(session_params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(session_params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
      #send error msg if user enter invaild pw or email 
      flash[:error] = "Please enter a vaild username and password"
      #send back to the login form.
      redirect_to '/signin'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private

    # Only allow a list of trusted parameters through.
    def session_params
      params.require(:user).permit(
      :email,
      :password
    )
    end
end