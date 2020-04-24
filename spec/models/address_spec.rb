require 'rails_helper'
RSpec.describe Address do
  describe "#create_address" do
    describe "バリデーション確認（presence true）" do
      
      it "全項目が入力されていれば登録できること" do
        address = build(:address)
        expect(address).to be_valid
      end

      it "送り先名字が空の場合は登録できないこと" do
        address = build(:address, ship_last_name: "")
        address.valid?
        expect(address.errors[:ship_last_name]).to include("can't be blank")
      end
      
      it "送り先名前が空の場合は登録できないこと" do
        address = build(:address, ship_first_name: "")
        address.valid?
        expect(address.errors[:ship_first_name]).to include("can't be blank")
      end
      
      it "送り先名字（かな）が空の場合は登録できないこと" do
        address = build(:address, ship_last_name_kana: "")
        address.valid?
        expect(address.errors[:ship_last_name_kana]).to include("can't be blank")
      end
      
      it "送り先名前（かな）が空の場合は登録できないこと" do
        address = build(:address, ship_last_name_kana: "")
        address.valid?
        expect(address.errors[:ship_last_name_kana]).to include("can't be blank")
      end
      
      it "郵便番号が空の場合は登録できないこと" do
        address = build(:address, postcode: "")
        address.valid?
        expect(address.errors[:postcode]).to include("can't be blank")
      end
      
      it "都道府県が空の場合は登録できないこと" do
        address = build(:address, prefecture: "")
        address.valid?
        expect(address.errors[:prefecture]).to include("can't be blank")
      end
      
      it "市町村が空の場合は登録できないこと" do
        address = build(:address, city: "")
        address.valid?
        expect(address.errors[:city]).to include("can't be blank")
      end
      
      it "番地が空の場合は登録できないこと" do
        address = build(:address, block: "")
        address.valid?
        expect(address.errors[:block]).to include("can't be blank")
      end
      
    end

    describe "バリデーション確認（regular expression）" do
      
      it "送り先名字（ふりがな）に半角文字が含まれていると登録できないこと" do
        address = build(:address, ship_last_name_kana: "ｱｲｳｴｵ")
        address.valid?
        expect(address).to be_invalid
      end

      it "送り先名前（ふりがな）に半角文字が含まれていると登録できないこと" do
        address = build(:address, ship_first_name_kana: "ｱｲｳｴｵ")
        address.valid?
        expect(address).to be_invalid
      end

      it "送り先名字（ふりがな）に漢字が含まれていると登録できないこと" do
        address = build(:address, ship_last_name_kana: "徳丸")
        address.valid?
        expect(address).to be_invalid
      end

      it "送り先名前（ふりがな）に漢字が含まれていると登録できないこと" do
        address = build(:address, ship_first_name_kana: "徳丸")
        address.valid?
        expect(address).to be_invalid
      end

      it "郵便番号に数字以外があれば登録できないこと" do
        address = build(:address, postcode: "556-0017")
        address.valid?
        expect(address).to be_invalid
      end
    end
  end
end