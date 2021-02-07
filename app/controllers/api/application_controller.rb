class Api::ApplicationController < ApplicationController
  before_action :set_current_user_from_header

  # include DecodeJwtToken

  def set_current_user_from_header
    auth_header = request.headers["auth-token"]
    jwt = auth_header.split(" ").last rescue nil
    payload = decode_token(token: jwt).first
    @current_user = User.find_by(auth_token: payload["auth_token"])
  rescue
    # return @current_user nil
  end

end
