class UsersController < ApplicationController
  def index
    @users = User.all.order(:created_at)
    respond_to do |format|
      format.html
      format.csv do
        send_data @users.to_csv
      end
    end
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

  def new
    @user = User.new
    @user.phone_numbers << ''
    @user.emails << ''
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was created'
    else
      @user.phone_numbers << ''
      @user.emails << ''
      render action: :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, notice: 'User was deleted'
  end

  def show
    @user = User.find(params[:id])
  end

  def csv_import
    User.import(params[:file])
    redirect_to users_url, notice: "Users imported"
  end

  def sharing
    user = User.find_by_id(params[:id])
    UserMailer.shared('some_guy@address_book.com', user).deliver_now
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, emails: [], phone_numbers: [])
  end
end
