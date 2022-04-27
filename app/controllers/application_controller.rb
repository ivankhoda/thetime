class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :require_jwt, except: %i[authentication]
  SECRET = 'yoursecretword'
  include SessionsHelper

  def require_jwt
    token = request.headers['HTTP_AUTHORIZATION']
    head :forbidden unless token
    head :forbidden unless valid_token(token)
  end

  def authentication
    decode_data = decode_user_data(request.headers['token'])
    user_data = decode_data[0]['user_id'] if decode_data
    user = User.find(user_data&.id)
    if user
      true
    else
      render json: { message: 'invalid credentials' }
    end
  end

  private

  def valid_token(token)
    return false unless token

    token.gsub!('Bearer ', '')
    begin
      decoded_token = JWT.decode token, SECRET, true
      return true
    rescue JWT::DecodeError
      Rails.logger.warn 'Error decoding the JWT'
      render json: { message: 'token is invalid' }
    end
    false
  end

  def encode_user_data(payload)
    puts payload
    JWT.encode payload, SECRET, 'HS256'
  end

  def decode_user_data(token)
    JWT.decode token, SECRET, true, { algorithm: 'HS256' }
  rescue StandardError => e
    puts e
  end
end
