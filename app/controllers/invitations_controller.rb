class InvitationsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    @user.invitation_accepted_at = Time.current

    if @user.save(context: :invitation)
      start_new_session_for @user
      redirect_to root_path, notice: "Welcome to #{@user.account.name}!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Findet den User nur über einen gültigen, nicht abgelaufenen,
  # noch nicht benutzten Token – sonst zurück zum Login
  def set_user_by_token
    @user = User.find_by_token_for(:invitation, params[:token])
    redirect_to new_session_path, alert: "This invitation link is invalid or has expired." unless @user
  end

  def user_params
    params.expect(user: %i[name password password_confirmation])
  end
end
