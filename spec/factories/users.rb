FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    # display_name { "MyString" }
    roles { ['admin'] }
    email { 'foo@bar.com' }
    username { Faker::Internet.username }
    password { 'foobar' }
  end
end
