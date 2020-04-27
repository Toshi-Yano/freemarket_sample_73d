FactoryBot.define do
  factory :address do
    ship_last_name      {"徳丸"}
    ship_first_name     {"みの里"}
    ship_last_name_kana {"とくまる"}
    ship_first_name_kana {"みのり"}
    postcode            {"5560017"}
    prefecture          {"大阪府"}
    city                {"大阪市浪速区"}
    block               {"湊町"}
  end
end