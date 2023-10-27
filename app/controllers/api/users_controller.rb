class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render json: { success: true, user_id: @user.id, message: 'Sign in was successful!' }
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
