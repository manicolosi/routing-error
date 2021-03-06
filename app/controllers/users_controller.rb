class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "Registration complete. You may now ask and " +
                        "answer questions!"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
