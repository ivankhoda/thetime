class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'You succesfully registred' }
    else
      render json: { error: @user.errors.messages }
    end
  end

  private def user_params
    puts params, 'parameteres'
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
