require 'rails_helper'
RSpec.describe Creditcard do
  describe "#create" do

    it "全て入力すると登録できる" do
      creditcard = create(:creditcard)
      expect(creditcard).to be_valid
    end

    it "customer_idが空の時は登録できないこと" do
      creditcard = build(:creditcard, customer_id: "")
      creditcard.valid?
      expect(creditcard.errors[:customer_id]).to include("can't be blank")
    end

    it "card_idが空の時は登録できないこと" do
      creditcard = build(:creditcard, card_id: "")
      creditcard.valid?
      expect(creditcard.errors[:card_id]).to include("can't be blank")
    end

    it "user_idが空だと登録できない" do
      creditcard = build(:creditcard, user_id: "")
      creditcard.valid?
      expect(creditcard.errors[:user]).to include("must exist")
    end

  end
end