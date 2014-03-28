class SessionsController < ApplicationController
  def new
  end


  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])

    if @user
      login_user!(@user) #create this method!
      redirect_to user_url(@user) #creat this

    else
      flash[:errors] = ["Ain't Got a User like Dat"]
      #HOW TO FLASH
      render :new
    end
  end

  def destroy
    logout_current_user!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

