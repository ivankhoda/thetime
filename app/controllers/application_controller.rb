class ApplicationController < ActionController::Base
  def index
    render json: 'hello there'
  end
end
