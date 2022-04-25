module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    new
  end

  def current_user
    decode_data = decode_user_data(request.headers['HTTP_AUTHORIZATION'])
    user_data = decode_data[0]['user_data'] if decode_data
    user = User.find_by(uuid: [user_data]) if user_data
    render json: { message: UserSerializer.new(user) }
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session[:user_id] = nil
    session.delete(:user_id)
  end
end
