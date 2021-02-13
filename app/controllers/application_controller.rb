class ApplicationController < ActionController::API
  before_action :set_user_from_token

  def set_user_from_token
    user = Token.get_user_from_request(request)
    not_authenticated unless user
    auto_login(user)
  end

  private

  def not_authenticated
    raise AuthenticationError.new("Please login first")
  end
end
