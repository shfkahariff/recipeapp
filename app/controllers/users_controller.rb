class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
    #@resource_name = :user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_index_path, notice: "User created."
    else
      redirect_to users_index_path, alert: "Unable to create user."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_index_path, notice: "User deleted."
  end

  def make_admin
    @user = User.find(params[:id])
    @user.role = "admin"
    if @user.save
      redirect_to users_index_path, notice: "User role updated to admin."
    else
      redirect_to users_index_path, alert: @user.errors.full_messages.to_sentence
    end
  end
  
  def make_hr
    @user = User.find(params[:id])
    @user.role = "HR"
    if @user.save
      redirect_to users_index_path, notice: "User role updated to HR."
    else
      redirect_to users_index_path, alert: @user.errors.full_messages.to_sentence
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :name, :profile_pic, :position, :address, :phoneno, :public_id)
  end

end
