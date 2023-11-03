class Api::UsersController < ApplicationController
  before_action :set_current_user, only: [:current]
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render json: { success: true, user_id: @user.id, message: 'Sign in was successful!' }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def current
    if @current_user
      render json: @current_user
    else
      render json: { error: 'Not logged in' }, status: :unauthorized
    end
  end

  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
