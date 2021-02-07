class ApplicationController < ActionController::API
  # before_action :set_user_from_token
  before_action :require_login

  def set_user_from_token
    user = Token.get_user_from_request(request)
    return unless user
    auto_login(user)
  end

  private

  def not_authenticated
    render json: "Please login first", status: :unauthorized
  end
end
