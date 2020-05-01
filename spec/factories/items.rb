FactoryBot.define do
  factory :item do
    user
    name                {"ジャケット"}
    description         {"かっこいいジャケットです"}
    category
    delivery_charge {1}
    prefecture {1}
    delivery_dates {1}
    condition {1}
    price               {5000}
    status              {1}
    # payer               {"購入者"}
    # brand               {"ユニクロ"}
    after(:build) do |item|                          
      item.images << build(:image, item: item)
    end
  end
end