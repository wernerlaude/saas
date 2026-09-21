require "rails_helper"

RSpec.describe "Invitations", type: :request do
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  let(:invitee) do
    User.create_and_invite(invited_by: admin, account: admin.account,
                           name: "Invited User", email_address: "invited@example.com")
  end
  let(:token) { invitee.generate_token_for(:invitation) }
  let(:valid_params) do
    { user: { name: "Invited User", password: "secret123", password_confirmation: "secret123" } }
  end

  it "sends an invitation email" do
    expect {
      User.create_and_invite(invited_by: admin, account: admin.account,
                             name: "Someone", email_address: "someone@example.com")
    }.to have_enqueued_mail(InvitationMailer, :instructions_email)
  end

  it "shows the form for a valid token" do
    get edit_invitation_path(token)
    expect(response).to have_http_status(:success)
  end

  it "rejects an invalid token" do
    get edit_invitation_path("invalid")
    expect(response).to redirect_to(new_session_path)
  end

  it "accepts the invitation and logs the user in" do
    patch invitation_path(token), params: valid_params
    expect(response).to redirect_to(root_path)
    expect(invitee.reload.invitation_accepted_at).to be_present
  end

  it "requires a password" do
    patch invitation_path(token), params: { user: { name: "Invited User", password: "", password_confirmation: "" } }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "cannot be used twice" do
    patch invitation_path(token), params: valid_params
    get edit_invitation_path(token)
    expect(response).to redirect_to(new_session_path)
  end
end