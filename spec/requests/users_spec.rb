require "rails_helper"

RSpec.describe "Users", type: :request do
  login_user

  it "lists only the users of my own account" do
    FactoryBot.create(:user, account: @user.account, name: "Colleague")
    FactoryBot.create(:user, name: "Stranger")

    get account_users_path

    expect(response.body).to include("Colleague")
    expect(response.body).not_to include("Stranger")
  end

  it "invites a new user into my account" do
    expect {
      post account_users_path, params: { user: { name: "New Person", email_address: "new@example.com", role: "user" } }
    }.to change(User, :count).by(1)
      .and have_enqueued_mail(InvitationMailer, :instructions_email)

    expect(User.last.account).to eq(@user.account)
    expect(response).to redirect_to(account_users_path)
  end

  it "does not allow editing users of another account" do
    stranger = FactoryBot.create(:user)

    get edit_account_user_path(stranger)

    expect(response).to have_http_status(:not_found)
  end

  it "does not allow removing yourself" do
    expect {
      delete account_user_path(@user)
    }.not_to change(User, :count)
  end
end
