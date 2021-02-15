class Api::User::OauthsController < ApplicationController
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    session[:return_to_url] = request.referer unless /oauth/.match?(request.referer)
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_back_or_to root_path, notice: "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)

        # NOTE: this is the place to add '@user.activate!'
        # if you are using user_activation submodule
        @user.try(:activate!)

        # reset_session clears session[:return_to_url], so calculate the
        # redirect first
        redirect_back_or_to root_path, notice: "Logged in from #{provider.titleize}!"

        reset_session # protect from session fixation attack
        auto_login(@user)
      rescue StandardError
        redirect_back_or_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end
end
