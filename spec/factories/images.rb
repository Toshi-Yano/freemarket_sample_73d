FactoryBot.define do

  factory :image do
    image   {File.open("#{Rails.root}/spec/fixtures/sample1.jpg")}
    item
  end
end