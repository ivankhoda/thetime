class SessionsController < ApplicationController
  protect_from_forgery with: :null_session
  def new
    render json: { message: session }
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      render json: { message: user }
    else
      # Create an error message.
      render json: { message: 'Invalid email/password combination' }

    end
  end

  def destroy
    log_out
    if session[:user_id].nil?
      render json: { message: 'You succesfully logout' }
    else
      render json: { message: 'Something went wrong' }
    end
  end
end
