class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    p "HI DUDE, HERE ARE YOUR PARAMS"
    p user_params

    if @user.save
      login_user!(@user) #write
      redirect_to user_url(@user) #show path bands/somethign or other
    else
      render :new #save the data of the form??
    end
  end

  def new
    @user = User.new #why do we do this? to fill out form? need a user we are gathering params for.
    render :new #dont need to put
  end



  def show
    @user = User.find(params[:id])
    #current_user = @user #NOT WHAT WE DID IN CATs of course...
    render :show

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
