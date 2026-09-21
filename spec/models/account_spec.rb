require "rails_helper"

RSpec.describe Account, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:account)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:account, name: nil)).to be_invalid
  end
end
