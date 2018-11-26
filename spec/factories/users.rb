FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    display_name { "MyString" }
    email { "MyString" }
    username { "MyString" }
    password_digest { "MyString" }
  end
end
