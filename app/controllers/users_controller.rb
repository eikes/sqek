class UsersController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def index
    @users = User.all
    respond_with(@users)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      respond_with(@user)
    end
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update(user_params)
      redirect_to users_path
    else
      respond_with(@user)
    end
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  private
    def user_params
      params.require(:user).permit(:email, :role, :password, :password_confirmation)
    end
end
