class Api::User::SessionsController < Api::ApplicationController
  skip_before_action :require_login, only: [:sign_up, :social_sign_up, :sign_in, :activate]

  def sign_up
    user = User.new(
      email: sign_up_params[:email],
      password: sign_up_params[:password],
      password_confirmation: sign_up_params[:password],
    )
    if user.save
      Profile.create(
        user: user,
        first_name: sign_up_params[:first_name],
        last_name: sign_up_params[:last_name],
      )
      AuthMailer.activation_needed_email(user.id).deliver_later
      render json: user.attributes, status: :ok
    else
      render json: user.errors, status: :bad_request
    end
  end

  def social_sign_up
    user_hash = Social.receive_user(sign_up_social_params[:type], sign_up_social_params[:access_token])
    user = User.create_from_provider(sign_up_social_params[:type], user_hash[:uid], { email: sign_up_social_params[:email] })

    if user
      user.activate!
      user.attributes.merge({ token: Token.build_from_user(user).token })

      render json: user.attributes, status: :ok
    else
      render json: user.errors, status: :bad_request
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      render json: 'User was successfully activated.', status: :ok
    else
      not_authenticated
    end
  end

  private

  def sign_up_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :username,
      :confirmation_email,
      :password,
      :confirmation_password
    )
  end

  def sign_up_social_params
    params.permit(
      :type,
      :access_token,
      :email
    )
  end
end
