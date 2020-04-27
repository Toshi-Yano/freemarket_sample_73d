FactoryBot.define do
  factory :user do
    nickname              {"tokumaru"}
    email                 {"tokumaru@gmail.com"}
    password              {"12345678"}
    password_confirmation {"12345678"}
    last_name             {"徳丸"}
    first_name            {"みの里"}
    last_name_kana        {"とくまる"}
    first_name_kana       {"みのり"}
    date_of_birth         {"20000101"}
  end
end