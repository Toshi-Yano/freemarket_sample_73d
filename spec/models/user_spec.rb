require 'rails_helper'
RSpec.describe User do
  describe "#create" do
    describe "バリデーション確認（presence true）" do

      it "全項目が入力されていれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end

      it "nicknameが空の場合は登録できないこと" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("can't be blank")
      end

      it "emailが空の場合は登録できないこと" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it "名字が空の場合は登録できないこと" do
        user = build(:user, last_name: nil)
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end

      it "名前が空の場合は登録できないこと" do
        user = build(:user, first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it "名字（ふりがな）が空の場合は登録できないこと" do
        user = build(:user, last_name_kana: nil)
        user.valid?
        expect(user.errors[:last_name_kana]).to include("can't be blank")
      end

      it "名前（ふりがな）が空の場合は登録できないこと" do
        user = build(:user, first_name_kana: nil)
        user.valid?
        expect(user.errors[:first_name_kana]).to include("can't be blank")
      end

      it "誕生日が空の場合は登録できないこと" do
        user = build(:user, date_of_birth: nil)
        user.valid?
        expect(user.errors[:date_of_birth]).to include("can't be blank")
      end

      it "パスワードが空の場合は登録できないこと" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it "パスワード（確認用）が一致しない（空）の場合は登録できないこと" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end

    describe "バリデーション確認（uniqueness,length,regular expression）" do
      
      it "重複したnicknameが登録できないこと" do
        user = create(:user)
        another_user = build(:user, nickname: user.nickname)
        another_user.valid?
        expect(another_user.errors[:nickname]).to include("has already been taken")
      end

      it "重複したemailが登録できないこと" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("has already been taken")
      end

      it "パスワードが7文字以上であれば登録できること" do
        user = build(:user, password: "1234567", password_confirmation: "1234567")
        user.valid?
        expect(user).to be_valid
      end

      it "パスワードが6文字以下であれば登録できないこと" do
        user = build(:user, password: "123456", password_confirmation: "123456")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
      end

      it "名字に半角文字が含まれていると登録できないこと" do
        user = build(:user, last_name: "ｱｲｳｴｵ")
        user.valid?
        expect(user).to be_invalid
      end

      it "名前に半角文字が含まれていると登録できないこと" do
        user = build(:user, first_name: "ｱｲｳｴｵ")
        user.valid?
        expect(user).to be_invalid
      end

      it "名字（ふりがな）に半角文字が含まれていると登録できないこと" do
        user = build(:user, last_name_kana: "ｱｲｳｴｵ")
        user.valid?
        expect(user).to be_invalid
      end

      it "名前（ふりがな）に半角文字が含まれていると登録できないこと" do
        user = build(:user, first_name_kana: "ｱｲｳｴｵ")
        user.valid?
        expect(user).to be_invalid
      end

      it "名字（ふりがな）に漢字が含まれていると登録できないこと" do
        user = build(:user, last_name_kana: "徳丸")
        user.valid?
        expect(user).to be_invalid
      end

      it "名前（ふりがな）に漢字が含まれていると登録できないこと" do
        user = build(:user, first_name_kana: "徳丸")
        user.valid?
        expect(user).to be_invalid
      end

    end
  end
end