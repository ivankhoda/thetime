class ApplicationController < ActionController::Base
  include SessionsHelper
  def index
    render json: 'hello there'
  end
end
