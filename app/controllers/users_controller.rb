class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = current_account.users.order(:name)
  end

  def new
    @user = current_account.users.new
  end

  def create
    @user = User.create_and_invite(invited_by: current_user, account: current_account,
                                   **user_params.to_h.symbolize_keys)

    if @user.persisted?
      redirect_to account_users_path, notice: "Invitation sent to #{@user.email_address}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to account_users_path, notice: "#{@user.name} was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to account_users_path, alert: "You can't remove yourself."
    else
      @user.destroy
      redirect_to account_users_path, notice: "#{@user.name} was removed.", status: :see_other
    end
  end

  private

  # Nur User des eigenen Accounts! Das Buch nutzt User.find(params[:id]) –
  # damit könnte jeder eingeloggte User fremde Accounts bearbeiten.
  # Fremde oder unbekannte IDs ergeben hier ein 404.
  def set_user
    @user = current_account.users.find_by_prefix_id!(params[:id])
  end

  def user_params
    params.expect(user: %i[name email_address role])
  end
end
