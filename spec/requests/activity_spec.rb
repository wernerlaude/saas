require "rails_helper"

RSpec.describe "Activity", type: :request do
  context "when logged in" do
    login_user

    it "shows my activity" do
      get activity_mine_path
      expect(response).to have_http_status(:success)
    end

    it "shows the feed" do
      get activity_feed_path
      expect(response).to have_http_status(:success)
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      get activity_mine_path
      expect(response).to redirect_to(new_session_path)
    end
  end
end
