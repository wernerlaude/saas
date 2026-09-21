FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    settings { {} }

    after(:build) do |account|
      account.user ||= FactoryBot.build(:user, account: account)
    end
  end
end
