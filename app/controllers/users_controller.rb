class UsersController < ApplicationController
  def index
    @users = User.all.order(:created_at)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was updated'
    else
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, emails: [], phone_numbers: [])
  end
end
