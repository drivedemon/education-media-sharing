class Api::ApplicationController < ApplicationController
  before_action :set_current_user_from_header

  include DecodeJwtToken

  def set_current_user_from_header
    auth_header = request.headers["auth-token"]
    jwt = auth_header.split(" ").last rescue nil
    payload = decode_token(token: jwt).first
    @current_user = User.find_by(auth_token: payload["auth_token"])
  rescue
    # return @current_user nil
  end

  rescue_from BadError, with: :handle_400
  rescue_from AuthenticationError, with: :handle_401
  rescue_from JWT::VerificationError, with: :handle_401
  rescue_from JWT::ExpiredSignature, with: :handle_401
  rescue_from JWT::DecodeError, with: :handle_401
  rescue_from ActiveRecord::RecordNotFound, with: :handle_404

  def handle_400(exception)
    render json: { success: false, error: exception.message }, status: :bad_request
  end

  def handle_401(exception)
    render json: { success: false, error: exception.message }, status: :unauthorized
  end

  def handle_404
    render json: { success: false, error: "Record not found" }, status: :not_found
  end

end
