class SessionsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :require_jwt, except: %i[create]

  # for testing only
  def find
    current_user
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      token = encode_user_data({ user: user.uuid })
      render json: { token: }
    else
      render json: { message: 'Invalid email/password combination' }
    end
  end

  def destroy
    log_out
    render json: { message: 'You succesfully logout' }
  end
end
