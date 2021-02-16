class Api::User::OauthsController < Api::ApplicationController
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    session[:return_to_url] = request.referer unless /oauth/.match?(request.referer)
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]

    # add callback_url
    if @user = login_from(provider)
      render json: @user.attributes.merge({callback_url: "https://education-media.vercel.app"}), status: :ok
    else
      begin
        @user = create_from(provider)

        # NOTE: this is the place to add '@user.activate!'
        # if you are using user_activation submodule
        @user.try(:activate!)

        # reset_session clears session[:return_to_url], so calculate the
        # redirect first
        render json: @user.attributes.merge({callback_url: "https://education-media.vercel.app/price"}), status: :ok

        reset_session # protect from session fixation attack
        auto_login(@user)
      rescue StandardError => e
        raise AuthenticationError.new(e)
      end
    end
  end
end
