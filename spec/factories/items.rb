FactoryBot.define do
  factory :item do
    user
    name                {"ジャケット"}
    description         {"かっこいいジャケットです"}
    category
    delivery_charge_id  {1}
    prefecture_id       {1}
    delivery_dates_id   {1}
    condition_id        {1}
    price               {5000}
    status              {1}
    after(:build) do |item|                          
      item.images << build(:image, item: item)
    # after(:build) do |item|                          
    #   item.images << FactoryBot.build(:image, image: "sample2.jpg")
    end
  end
end