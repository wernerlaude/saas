class InvitationMailer < ApplicationMailer
  def instructions_email
    @user = params[:user]
    @token = @user.generate_token_for(:invitation)

    mail to: @user.email_address, subject: "You're invited to join #{@user.account.name}"
  end
end
