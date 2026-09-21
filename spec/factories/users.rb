FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email_address { Faker::Internet.unique.email }
    time_zone { "Berlin" }
    password { "password" }

    # User und Account verweisen gegenseitig aufeinander –
    # Account nur anlegen, wenn keiner übergeben wurde
    after(:build) do |user|
      user.account ||= FactoryBot.build(:account, user: user)
    end
  end
end
