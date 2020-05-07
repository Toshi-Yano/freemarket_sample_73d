FactoryBot.define do
  factory :creditcard do
    user
    customer_id {"1234567890"}
    card_id     {"0987654321"}
  end
end