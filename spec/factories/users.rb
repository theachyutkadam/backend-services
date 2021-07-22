FactoryBot.define do
  factory :user do
    first_name { "first_name" }
    last_name { "last_name" }
    email { "email@email.com" }
    password { "123456" }
    birthdate { "1996-07-22" }
    contact { "9639638524" }
  end
end
