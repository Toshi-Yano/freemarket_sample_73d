require 'rails_helper'
RSpec.describe Item do
  describe "#create" do
    describe "バリデーション確認(presence true)" do

      it "全項目が入力されていれば登録できること" do
        item = build(:item)
        expect(item).to be_valid
      end

      xit "画像複数枚でも登録できること" do
        item = build(:item)
        expect(item).to be_valid
      end

      it "商品名が空の場合は登録できないこと" do
        item = build(:item, name: nil)
        # item.valid?
        # expect(item.errors[:name]).to include("can't be bank")
        expect(item.valid?).to eq(false)
      end

    end
  end
end