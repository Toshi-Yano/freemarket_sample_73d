FactoryBot.define do
  factory :item do
    name                {"ジャケット"}
    description         {"かっこいいジャケットです"}
    condition           {"すごく良いです"}
    delivery_charge     {"1000円"}
    delivery_prefecture {"大阪"}
    delivery_dates      {"3日"}
    price               {"5000"}
    status              {"1"}
    category
    # image
    # user
    # order
    # payer               {"購入者"}
    # brand               {"ユニクロ"}
    # association :image,
    #   factory: :image,
    #   strategy: :build,
    #   admin: true
    # association :category,
    #   factory: :category,
    #   strategy: :build,
    #   admin: true
  end

  factory :category do
    name {"トップス"}
  end
  # factory :image do
  #   image {File.open("#{Rails.root}/public/material/test/sample1.jpg")}
  # end
end