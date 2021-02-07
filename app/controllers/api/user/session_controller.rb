class Api::User::SessionController < Api::ApplicationController
  skip_before_action :set_current_user_from_header, only: [:sign_up, :sign_in]

  def sign_up
    user = User.new(merge_first_row(user_params, params[:images]).merge({ password: params[:telephone] }))
    if user.save
      store_and_trigger_notification_job(:user_sign_up, {sign_up_user_id: user.id})
      render json: user.as_json_with_jwt, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
