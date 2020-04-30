FactoryBot.define do
  factory :item do
    user
    # user                {2}
    name                {"ジャケット"}
    description         {"かっこいいジャケットです"}
    category
    # category            {1}
    # condition_id {1}
    # delivery_charge_id {1}
    # prefecture_id {1}
    # delivery_dates_id {1}
    price               {5000}
    status              {1}
    # payer               {"購入者"}
    # brand               {"ユニクロ"}
    after(:build) do |item|                          
      item.images << build(:image, item: item)
    end
  end
end