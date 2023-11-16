class Api::SessionsController < ApplicationController
  def create
    puts "Debugging Params: #{params.inspect}"
    user = User.find_by(email: params[:email])
    puts "Debugging User: #{user.inspect}"

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { success: true, user_id: user.id }
    else
      render json: { error: 'User not found or wrong password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { success: true }
  end
end
