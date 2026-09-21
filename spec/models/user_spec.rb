require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "normalizes the email address" do
    user = FactoryBot.build(:user, email_address: "  Werner@Example.COM ")
    expect(user.email_address).to eq("werner@example.com")
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:user, name: nil)).to be_invalid
  end
end