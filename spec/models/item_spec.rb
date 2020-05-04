require 'rails_helper'
RSpec.describe Item do
  describe "#create" do

      it "全て入力すると登録できる" do
        item = create(:item)
        expect(item).to be_valid
      end
  
      it "nameが空だと登録できない" do
        item = build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end
  
      it "priceが空だと登録できない" do
        item = build(:item, price: "")
        item.valid?
        expect(item.errors[:price]).to include("can't be blank")
      end
  
      it "descriptionが空だと登録できない" do
        item = build(:item, description: "")
        item.valid?
        expect(item.errors[:description]).to include("can't be blank")
      end
  
      it "conditionが空だと登録できない" do
        item = build(:item, condition_id: "")
        item.valid?
        expect(item.errors[:condition_id]).to include("can't be blank")
      end
  
      it "prefectureが空だと登録できない" do
        item = build(:item, prefecture_id: "")
        item.valid?
        expect(item.errors[:prefecture_id]).to include("can't be blank")
      end
  
      it "delivery_chargeが空だと登録できない" do
        item = build(:item, delivery_charge_id: "")
        item.valid?
        expect(item.errors[:delivery_charge_id]).to include("can't be blank")
      end
  
      it "delivery_datesが空だと登録できない" do
        item = build(:item, delivery_dates_id: "")
        item.valid?
        expect(item.errors[:delivery_dates_id]).to include("can't be blank")
      end
  
      it "statusが空だと登録できない" do
        item = build(:item, status: "")
        item.valid?
        expect(item.errors[:status]).to include("can't be blank")
      end
  
      it "user_idが空だと登録できない" do
        item = build(:item, user_id: "")
        item.valid?
        expect(item.errors[:user]).to include("must exist")
      end
  
      it "category_idが空だと登録できない" do
        item = build(:item, category_id: "")
        item.valid?
        expect(item.errors[:category]).to include("must exist")
      end
      
      it "imageが空だと登録できない" do
        item = build(:item.images, image: "")
        item.valid?
        expect(item.errors[:item.images]).to include("can't be blank")
      end

  end
end