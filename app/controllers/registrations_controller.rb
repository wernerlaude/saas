class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
    @account = Account.new
  end

  def create
    @user = User.new(user_params)
    @account = @user.account = Account.new(account_params.merge(user: @user))

    # Wer ein Konto anlegt, verwaltet es. Eingeladene User bekommen
    # später den Default :user.
    @user.role = :admin

    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "Registration successful."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: %i[name email_address password password_confirmation])
  end

  def account_params
    params.expect(account: [ :name ])
  end
end
