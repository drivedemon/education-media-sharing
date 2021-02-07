class AuthMailer < ApplicationMailer
  def activation_needed_email(user_id)
    @user = User.find(user_id)
    @url = "http://localhost:3000/api/user/activate?id=#{@user.activation_token}"
    mail(to: @user.email, subject: 'Education Media Sharing - Email Confirmation')
  end

  def activation_success_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Education Media Sharing - Your account is now activated')
  end

  def reset_password_email(user)
    # @user = user
    # @url = get_url(user, 'ForgotPasswordVerification', user.reset_password_token)
    # mail(to: user[:email], subject: 'Education Media Sharing - Reset Password Instruction!')
  end
end
