class Api::User::SessionsController < Api::ApplicationController
  skip_before_action :set_user_from_token, only: [:sign_up, :social_sign_up, :sign_in, :activate, :delete]

  def sign_up
    user = User.new(
      email: sign_up_params[:email],
      password: sign_up_params[:password],
      password_confirmation: sign_up_params[:confirmation_password],
    )
    user.save

    user.create_profile(sign_up_params.except(:email, :password, :confirmation_password, :confirmation_email))
    AuthMailer.activation_needed_email(user_id: user.id).deliver_later

    render json: user.attributes, status: :ok
  rescue => e
    render json: e, status: :bad_request
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

  def sign_in
    user = User.authenticate(params[:email], params[:password])

    if user
      render json: user.attributes.merge({ token: Token.build_from_user(user) }), status: :ok
    else
      render json: "Invalid email or password!", status: :bad_request
    end
  end

  def me
    render json: current_user.attributes, status: :ok
  end

  def delete
    user = User.find(params[:id])

    if user.destroy
      render json: "Deleted!", status: :ok
    else
      render json: "Invalid email or password!", status: :bad_request
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to "https://education-media.vercel.app/login"
    else
      not_authenticated
    end
  end

  private

  def sign_up_params
    params.permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :confirmation_email,
      :password,
      :confirmation_password,
      :street_line1,
      :street_line2,
      :sub_district,
      :district,
      :province,
      :postcode,
      :professional,
      :educational,
      :work_place,
      :national_id,
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
